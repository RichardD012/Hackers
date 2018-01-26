//
//  NewsViewController.swift
//  Hackers2
//
//  Created by Weiran Zhang on 07/06/2014.
//  Copyright (c) 2014 Glass Umbrella. All rights reserved.
//

import Foundation
import UIKit
import SafariServices
import libHN
import PromiseKit
import SkeletonView
import Kingfisher

class NewsViewController : UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [HNPost] = [HNPost]()
    var postType: PostFilterType! = .top
    
    private var collapseDetailViewController = true
    private var peekedIndexPath: IndexPath?
    private var thumbnailProcessedUrls = [String]()
    private var nextPageIdentifier: String?
    private var isProcessing: Bool = false
    private var viewIsUnderTransition = false
    
    private var cancelFetch: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForPreviewing(with: self, sourceView: tableView)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NewsViewController.loadPosts), for: UIControlEvents.valueChanged)
        tableView.refreshControl = refreshControl
        
        splitViewController!.delegate = self
        
        self.view.backgroundColor = Theme.navigationBarBackgroundColor
        
        NotificationCenter.default.addObserver(self, selector: #selector(themeChanged(_:)), name: .themeChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NewsViewController.viewDidRotate), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        view.showAnimatedSkeleton(usingColor: Theme.skeletonBaseColor)
        loadPosts()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(self, name: .themeChanged, object: nil)
    }
    
    override func awakeFromNib() {
        /*
         TODO: workaround for an iOS 11 bug: if prefersLargeTitles is set in storyboard,
         it never shrinks with scroll. When fixed, remove from code and set in storyboard.
        */
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.largeTitleDisplayMode = .always
    }
    
    @objc private func themeChanged(_ notification: Notification) {
        self.view.backgroundColor = Theme.navigationBarBackgroundColor
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rz_smoothlyDeselectRows(tableView: tableView)
    }

    func getSafariViewController(_ url: URL) -> SFSafariViewController {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.previewActionItemsDelegate = self
        return safariViewController
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        viewIsUnderTransition = true
    }
    
    @objc func viewDidRotate() {
        guard let tableView = self.tableView, let indexPaths = tableView.indexPathsForVisibleRows, !isProcessing, viewIsUnderTransition else { return }
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: indexPaths, with: .automatic)
        self.tableView.endUpdates()
        viewIsUnderTransition = false
    }
}

extension NewsViewController { // post fetching
    @objc func loadPosts() {
        if(isProcessing)
        {
            return
        }
    
        isProcessing = true
        
        // cancel existing fetches
        if let cancelFetch = cancelFetch {
            cancelFetch()
            self.cancelFetch = nil
        }
        
        // fetch new posts
        let (fetchPromise, cancel) = fetch()
        fetchPromise
            .then { (posts, nextPageIdentifier) -> Void in
                self.cancelFetch = nil
                self.posts = posts ?? [HNPost]()
                //check if any of the new posts have been read already
                for post in self.posts {
                    if(DataPersistenceManager.hasVisited(post: post))
                    {
                        post.hasVisited=true
                    }
                }
                self.nextPageIdentifier = nextPageIdentifier
                self.view.hideSkeleton()
                self.tableView.rowHeight = UITableViewAutomaticDimension
                self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
                self.tableView.reloadData()
                
            }
            .always {
                self.view.hideSkeleton()
                self.isProcessing = false
                self.tableView.refreshControl?.endRefreshing()
        }
        
        cancelFetch = cancel
    }
    
    func fetch() -> (Promise<([HNPost]?, String?)>, cancel: () -> Void) {
        var cancelMe = false
        var cancel: () -> Void = { }
        
        let promise = Promise<([HNPost]?, String?)> { fulfill, reject in
            cancel = {
                cancelMe = true
                reject(NSError.cancelledError())
            }
            HNManager.shared().loadPosts(with: postType) { posts, nextPageIdentifier in
                guard !cancelMe else {
                    reject(NSError.cancelledError())
                    return
                }
                if let posts = posts as? [HNPost] {
                    fulfill((posts, nextPageIdentifier))
                }
            }
        }
        
        return (promise, cancel)
    }
    
    func loadMorePosts() {
        guard let nextPageIdentifier = nextPageIdentifier else { return }
        self.nextPageIdentifier = nil
        HNManager.shared().loadPosts(withUrlAddition: nextPageIdentifier) { posts, nextPageIdentifier in
            if let downcastedArray = posts as? [HNPost] {
                self.nextPageIdentifier = nextPageIdentifier
                self.posts.append(contentsOf: downcastedArray)
                self.tableView.reloadData()
            }
        }
    }
    
    func didPressCommentButton(_ post: HNPost) {
       collapseDetailViewController = false
        guard let navController = storyboard?.instantiateViewController(withIdentifier: "PostViewNavigationController") as? UINavigationController else { return }
        guard let commentsViewController = navController.viewControllers.first as? CommentsViewController else { return }
        commentsViewController.post = post
        if UIDevice.current.userInterfaceIdiom == .phone {
            // for iPhone we want to push the view controller instead of presenting it as the detail
            self.navigationController?.pushViewController(commentsViewController, animated: true)
        } else {
            showDetailViewController(navController, sender: self)
        }
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.delegate = self
        
        let post = posts[indexPath.row]
        cell.postTitleView.post = post
        cell.postCommentsImage.isHidden = false
        cell.postCommentsCount.text = String(post.commentCount)
        cell.postCommentsCount.isHidden = false
        cell.postCommentsCount.textColor = Theme.commentIconTextColor
        cell.postCommentsImage.tintColor = Theme.commentIconImageColor
        cell.postTitleView.delegate = self
        return cell
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let postCell = tableView.cellForRow(at: indexPath) as? PostCell else {return }
        collapseDetailViewController = false
        posts[indexPath.row].hasVisited = true
        DataPersistenceManager.setVisited(post: posts[indexPath.row])
        postCell.postTitleView.post = posts[indexPath.row]
        didPressLinkButton(posts[indexPath.row])
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == posts.count - 5 {
            loadMorePosts()
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? PostCell {
            cell.cancelThumbnailTask?()
        }
    }
}

extension NewsViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdenfierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "SkeletonCell"
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
}

extension NewsViewController: UIViewControllerPreviewingDelegate, SFSafariViewControllerPreviewActionItemsDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = tableView.indexPathForRow(at: location), posts.count > indexPath.row else { return nil }
        let post = posts[indexPath.row]
        if let url = URL(string: post.urlString), verifyLink(post.urlString) {
            peekedIndexPath = indexPath
            previewingContext.sourceRect = tableView.rectForRow(at: indexPath)
            return getSafariViewController(url)
        }
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        present(viewControllerToCommit, animated: true, completion: nil)
    }
    
    func safariViewControllerPreviewActionItems(_ controller: SFSafariViewController) -> [UIPreviewActionItem] {
        let indexPath = self.peekedIndexPath!
        let post = posts[indexPath.row]
        let commentsPreviewActionTitle = post.commentCount > 0 ? "View \(post.commentCount) comments" : "View comments"
        
        let viewCommentsPreviewAction = UIPreviewAction(title: commentsPreviewActionTitle, style: .default) {
            [unowned self, indexPath = indexPath] (action, viewController) -> Void in
            self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            self.tableView(self.tableView, didSelectRowAt: indexPath)
        }
        return [viewCommentsPreviewAction]
    }
}

extension NewsViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return collapseDetailViewController
    }
}

extension NewsViewController: PostTitleViewDelegate {
    func didPressLinkButton(_ post: HNPost) {
        guard verifyLink(post.urlString) else { return }
        if let url = URL(string: post.urlString) {
            self.navigationController?.present(getSafariViewController(url), animated: true, completion: nil)
        }
    }
    
    func verifyLink(_ urlString: String?) -> Bool {
        guard let urlString = urlString, let url = URL(string: urlString) else { return false }
        return UIApplication.shared.canOpenURL(url)
    }
}

extension NewsViewController: PostCellDelegate {
    
    func didTapComment(_ sender: Any) {
        guard let tapGestureRecognizer = sender as? UITapGestureRecognizer else { return }
        let point = tapGestureRecognizer.location(in: tableView)
        if let indexPath = tableView.indexPathForRow(at: point) {
            let post = posts[indexPath.row]
            didPressCommentButton(post)
        }
    }
}
