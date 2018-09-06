//
//  CommentsViewController.swift
//  Hackers2
//
//  Created by Weiran Zhang on 07/06/2014.
//  Copyright (c) 2014 Glass Umbrella. All rights reserved.
//

import Foundation
import UIKit
import SafariServices
import libHN
import DZNEmptyDataSet
import SkeletonView

class CommentsViewController : UIViewController {
    var post: HNPost?
    private var hairline : UIView?
    var comments: [CommentModel]? {
        didSet { commentsController.comments = comments! }
    }
    
    let commentsController = CommentsController()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var postContainerView: UIView!
    @IBOutlet weak var postTitleView: PostTitleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPostTitleView()
        
        tableView.backgroundView = nil
        tableView.backgroundColor = Theme.tableBackgroundColor
        postContainerView.backgroundColor = Theme.commentsViewPostBackgroundColor
        NotificationCenter.default.addObserver(self, selector: #selector(themeChanged(_:)), name: .themeChanged, object: nil)

        navigationItem.largeTitleDisplayMode = .never
        
        view.showSkeleton(usingColor: Theme.skeletonBaseColor);
        //view.showAnimatedSkeleton(usingColor: Theme.skeletonBaseColor)
        loadComments()
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func themeChanged(_ notification: Notification) {
        guard let post = post else { return }
        if(self.navigationController != nil)
        {
            Theme.setupUIColors(navigationBar: self.navigationController!.navigationBar)
        }
        if(self.tabBarController != nil)
        {
            Theme.setupUIColors(tabBar: self.tabBarController!.tabBar)
        }
        postContainerView.backgroundColor = Theme.commentsViewPostBackgroundColor
        postTitleView.backgroundColor = Theme.commentsViewPostBackgroundColor
        postTitleView.post = post //this will redraw the postTitleView
        hairline?.backgroundColor = Theme.commentsViewPostSeparatorColor
        Theme.setupUIColors(tableView:tableView)
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let headerView = tableView.tableHeaderView {
            let height = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
            var headerFrame = headerView.frame

            // If we don't have this check, viewDidLayoutSubviews() will get called infinitely
            if height != headerFrame.size.height {
                headerFrame.size.height = height
                headerView.frame = headerFrame
                tableView.tableHeaderView = headerView
            }
        }
        
        if hairline == nil {
            hairline = UIView()
            hairline?.backgroundColor = Theme.commentsViewPostSeparatorColor
            postContainerView.addSubview(hairline!)
        }
        hairline?.frame = CGRect(origin: CGPoint(x: 0, y: postContainerView.bounds.height), size: CGSize(width: postContainerView.bounds.width, height: 1 / UIScreen.main.scale))
    }
    
    func loadComments() {
        if(self.comments == nil){
            HNManager.shared().loadComments(from: post) { comments in
                if let downcastedArray = comments as? [HNComment] {
                    let mappedComments = downcastedArray.map { CommentModel(source: $0) }
                    self.comments = mappedComments
                } else {
                    self.comments = [CommentModel]()
                }
                
                self.view.hideSkeleton()
                self.tableView.rowHeight = UITableViewAutomaticDimension
                self.tableView.reloadData()
            }
        }else{
            self.view.hideSkeleton()
            self.tableView.rowHeight = UITableViewAutomaticDimension
            self.tableView.reloadData()
        }
    }
    
    func setupPostTitleView() {
        guard let post = post else { return }
        postTitleView.post = post
        postTitleView.delegate = self
        postTitleView.isTitleTapEnabled = true
    }
    
    @IBAction func didTapThumbnail(_ sender: Any) {
        didPressLinkButton(post!, view: self.postTitleView)
    }
    
    @IBAction func shareTapped(_ sender: AnyObject) {
        let activityViewController = UIActivityViewController(activityItems: [post!.title, URL(string: post!.urlString)!], applicationActivities: nil)
        activityViewController.popoverPresentationController?.barButtonItem = sender as? UIBarButtonItem
        present(activityViewController, animated: true, completion: nil)
    }
}

extension CommentsViewController: PostTitleViewDelegate {
    func didPressLinkButton(_ post: HNPost, view: PostTitleView) {
        if verifyLink(post.urlString), let url = URL(string: post.urlString) {
            // animate background colour for tap
            view.setVisited(post)
            
            self.postTitleView.backgroundColor = Theme.unselectedCellBackgroundColor
            //self.tableView.tableHeaderView?.backgroundColor = Theme.selectedCellBackgroundColor
            UIView.animate(withDuration: 0.3, animations: {
                self.postTitleView.backgroundColor = Theme.unselectedCellBackgroundColor
                //self.tableView.tableHeaderView?.backgroundColor = Theme.selectedCellBackgroundColor
            })
            
            // show link
            let safariViewController = Utils.getSafariViewController(url)
            self.present(safariViewController, animated: true, completion: nil)
            let postDataDictionary:[String: HNPost] = ["post": post]
            //set in data persistence
            NotificationCenter.default.post(name: .postVisited, object: nil, userInfo: postDataDictionary)
        }
    }
    
    func verifyLink(_ urlString: String?) -> Bool {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return false
        }
        return UIApplication.shared.canOpenURL(url)
    }
}

extension CommentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsController.visibleComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = commentsController.visibleComments[indexPath.row]
        assert(comment.visibility != .hidden, "Cell cannot be hidden and in the array of visible cells")
        let cellIdentifier = comment.visibility == CommentVisibilityType.visible ? "OpenCommentCell" : "ClosedCommentCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CommentTableViewCell
        cell.backgroundColor = Theme.unselectedCellBackgroundColor
        cell.comment = comment
        cell.delegate = self
        
        return cell
    }
}

/*extension CommentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = Bundle.main.loadNibNamed("CommentsHeader", owner: nil, options: nil)?.first as? UIView
        return view
    }
}*/

extension CommentsViewController: CommentDelegate {
    func commentTapped(_ sender: UITableViewCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            toggleCellVisibilityForCell(indexPath)
        }
    }
    
    func linkTapped(_ URL: Foundation.URL, sender: UITextView) {
        if URL.absoluteString.range(of:"news.ycombinator.com/item?id=") != nil {
            let url = URL.absoluteString
            HNManager.shared().loadPost(withPostUrl:url) { post, comments in
                if post != nil{
                    guard let navController = self.storyboard?.instantiateViewController(withIdentifier: "PostViewNavigationController") as? UINavigationController else { return }
                    guard let commentsViewController = navController.viewControllers.first as? CommentsViewController else { return }
                    commentsViewController.post = post
                    if let downcastedArray = comments as? [HNComment] {
                        let mappedComments = downcastedArray.map { CommentModel(source: $0) }
                        commentsViewController.comments = mappedComments
                    } else {
                        commentsViewController.comments = [CommentModel]()
                    }
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        // for iPhone we want to push the view controller instead of presenting it as the detail
                        self.navigationController?.pushViewController(commentsViewController, animated: true)
                    } else {
                        self.showDetailViewController(navController, sender: self)
                    }
                }
            }
        }else{
            let safariViewController = Utils.getSafariViewController(URL)
            self.present(safariViewController, animated: true, completion: nil)
        }
    }
    
    func toggleCellVisibilityForCell(_ indexPath: IndexPath!) {
        guard commentsController.visibleComments.count > indexPath.row else { return }
        let comment = commentsController.visibleComments[indexPath.row]
        let (modifiedIndexPaths, visibility) = commentsController.toggleCommentChildrenVisibility(comment)
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .fade)
        if visibility == CommentVisibilityType.hidden {
            tableView.deleteRows(at: modifiedIndexPaths, with: .top)
        } else {
            tableView.insertRows(at: modifiedIndexPaths, with: .top)
        }
        tableView.endUpdates()
        
        let cellRectInTableView = tableView.rectForRow(at: indexPath)
        let cellRectInSuperview = tableView.convert(cellRectInTableView, to: tableView.superview)
        if cellRectInSuperview.origin.y < 0 {
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
}

extension CommentsViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15.0)]
        return comments == nil ? NSAttributedString(string: "Loading comments", attributes: attributes) : NSAttributedString(string: "No comments", attributes: attributes)
    }
}

extension CommentsViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        if(Theme.isDarkMode)
        {
            return "SkeletonCellDark"
        }else{
            return "SkeletonCell"
        }
        
    }
}
