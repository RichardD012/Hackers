//
//  FeedViewController.swift
//  Hackers
//
//  Created by Weiran Zhang on 07/06/2014.
//  Copyright (c) 2014 Weiran Zhang. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import SafariServices
import PromiseKit
import Kingfisher
import Loaf
import SwipeCellKit

class FeedViewController: UITableViewController {
    var authenticationUIService: AuthenticationUIService?
    var swipeCellKitActions: SwipeCellKitActions?

    private var posts = [Post]()
    private var dataSource: UITableViewDiffableDataSource<Section, Post>?
    var postType: PostType = .news

    private var peekedIndexPath: IndexPath?
    private var pageIndex = 1
    private var isFetching = false

    private var notificationToken: NotificationToken?

    private var navigationBarGestureRecognizer: UITapGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        registerForPreviewing(with: self, sourceView: tableView)

        setupTheming()
        setupAuthenticationObserver()
        setupTableView()
        setupTitle()
        fetchPosts()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if UIScreen.main.traitCollection.horizontalSizeClass == .compact {
            // only deselect in compact size where the view isn't split
            smoothlyDeselectRows()
        }

        prepareNavigationTapRecognizer()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeNavigationTapRecognizer()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCommentsSegue",
            let navigationController = segue.destination as? UINavigationController,
            let commentsViewController = navigationController.viewControllers.first as? CommentsViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            commentsViewController.post = posts[indexPath.row]
        }
    }

    private func navigateToComments() {
        performSegue(withIdentifier: "ShowCommentsSegue", sender: self)
    }

    private func setupTableView() {
        tableView.refreshControl?.addTarget(
            self,
            action: #selector(fetchPostsWithReset),
            for: UIControl.Event.valueChanged
        )
        tableView.tableFooterView = UIView(frame: .zero) // remove cell separators on empty table
        dataSource = makeDataSource()
        tableView.dataSource = dataSource
        tableView.backgroundView = TableViewBackgroundView.loadingBackgroundView()
    }

    private func setupAuthenticationObserver() {
        notificationToken = NotificationCenter.default
        .observe(name: Notification.Name.refreshRequired,
                 object: nil,
                 queue: .main
        ) { _ in
            self.fetchPostsWithReset()
        }
    }

    @IBAction func showNewSettings(_ sender: Any) {
        let settingsStore = SettingsStore()
        let hostingVC = UIHostingController(
            rootView: SettingsView()
                .environmentObject(settingsStore))
        present(hostingVC, animated: true)
    }
}

extension FeedViewController { // post fetching
    @objc private func fetchPosts() {
        guard !isFetching else { return }

        isFetching = true
        let isFirstPage = pageIndex == 1

        firstly {
            HackersKit.shared.getPosts(type: postType, page: pageIndex)
        }.done { posts in
            if isFirstPage {
                self.posts = [Post]()
            }
            self.posts.append(contentsOf: posts)
            self.update(with: self.posts, animate: !isFirstPage)
        }.catch { error in
            Loaf("Error connecting to Hacker News", state: .error, sender: self).show()
        }.finally {
            self.isFetching = false
            self.tableView.refreshControl?.endRefreshing()
            self.pageIndex += 1
        }
    }

    @objc private func fetchPostsWithReset() {
        pageIndex = 1
        fetchPosts()
    }
}

extension FeedViewController { // post type selector
    private func setupTitle() {
        let titleLabel = TappableNavigationTitleView()
        titleLabel.setTitleText(postType.title)
        navigationItem.titleView = titleLabel
        title = postType.title
    }

    private func prepareNavigationTapRecognizer() {
        if navigationBarGestureRecognizer == nil {
            let gestureRecognizer = UITapGestureRecognizer(
                target: self,
                action: #selector(navigationBarTapped(_:))
            )
            gestureRecognizer.cancelsTouchesInView = false
            navigationBarGestureRecognizer = gestureRecognizer
        }

        if let gestureRecognizer = navigationBarGestureRecognizer {
            navigationController?.navigationBar.addGestureRecognizer(gestureRecognizer)
            navigationBarGestureRecognizer = gestureRecognizer
        }
    }

    private func removeNavigationTapRecognizer() {
        if let gestureRecognizer = navigationBarGestureRecognizer {
            navigationController?.navigationBar.removeGestureRecognizer(gestureRecognizer)
        }
    }

    @objc private func navigationBarTapped(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: navigationController?.navigationBar)
        let hitView = navigationController?.navigationBar.hitTest(location, with: nil)

        // let the tap fall through if its on a button
        guard !(hitView is UIControl) else {
            return
        }

        // haptic feedback
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()

        let controller = NavigationAlertController()
        controller.setup(handler: navigationAlertControllerHandler(postType:))
        controller.popoverPresentationController?.sourceView = navigationController?.navigationBar
        present(controller, animated: true)
    }

    private func navigationAlertControllerHandler(postType: PostType) {
        self.postType = postType

        // haptic feedback
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.success)

        // update title
        setupTitle()

        // reset tableview
        self.posts = [Post]()
        self.update(with: self.posts, animate: false)

        fetchPostsWithReset()
    }
}

extension FeedViewController { // table view data source
    enum Section: CaseIterable {
        case main
    }

    func makeDataSource() -> UITableViewDiffableDataSource<Section, Post> {
        let reuseIdentifier = "PostCell"

        return UITableViewDiffableDataSource(tableView: tableView) { (tableView, indexPath, post) in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: reuseIdentifier,
                for: indexPath
            ) as? PostCell else { return nil }
            cell.postDelegate = self
            cell.delegate = self

            cell.postTitleView.post = post
            cell.postTitleView.delegate = self

            cell.setImageWithPlaceholder(
                url: UserDefaults.standard.showThumbnails ? post.url : nil
            )

            return cell
        }
    }

    func update(with posts: [Post], animate: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Post>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(posts)
        self.dataSource?.apply(snapshot, animatingDifferences: animate)
    }
}

extension FeedViewController { // table view delegate
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let buffer: CGFloat = 200
        let scrollPosition = scrollView.contentOffset.y
        let bottomPosition = scrollView.contentSize.height - scrollView.frame.size.height

        if scrollPosition > bottomPosition - buffer {
            fetchPosts()
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        if postType == .jobs {
            didPressLinkButton(post)
        } else {
            navigateToComments()
        }
    }
}

extension FeedViewController: SwipeTableViewCellDelegate { // swipe cell delegate
    func tableView(_ tableView: UITableView,
                   editActionsForRowAt indexPath: IndexPath,
                   for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        let post = posts[indexPath.row]
        guard orientation == .left,
            post.postType != .jobs else {
                return nil
        }

        return swipeCellKitActions?.voteAction(post: post, tableView: tableView,
                                               indexPath: indexPath, viewController: self)
    }

    func tableView(_ tableView: UITableView,
                   editActionsOptionsForRowAt indexPath: IndexPath,
                   for orientation: SwipeActionsOrientation) -> SwipeOptions {
        let expansionStyle = SwipeExpansionStyle(target: .percentage(0.2),
                                                 elasticOverscroll: false,
                                                 completionAnimation: .bounce)
        var options = SwipeOptions()
        options.expansionStyle = expansionStyle
        options.expansionDelegate = BounceExpansion()
        options.transitionStyle = .drag
        return options
    }
}

extension FeedViewController: PostTitleViewDelegate, PostCellDelegate { // cell actions
    func didPressLinkButton(_ post: Post) {
        if let safariViewController = SFSafariViewController.instance(
            for: post.url,
            previewActionItemsDelegate: self
        ) {
            navigationController?.present(safariViewController, animated: true)
        }
    }

    func didTapThumbnail(_ sender: Any) {
        guard let tapGestureRecognizer = sender as? UITapGestureRecognizer else { return }
        let point = tapGestureRecognizer.location(in: tableView)
        if let indexPath = tableView.indexPathForRow(at: point) {
            let post = posts[indexPath.row]
            didPressLinkButton(post)
        }
    }
}

extension FeedViewController: UIViewControllerPreviewingDelegate, SFSafariViewControllerPreviewActionItemsDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing,
                           viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard
            let indexPath = tableView.indexPathForRow(at: location),
            posts.count > indexPath.row else {
                return nil
        }
        let post = posts[indexPath.row]
        if UIApplication.shared.canOpenURL(post.url) {
            peekedIndexPath = indexPath
            previewingContext.sourceRect = tableView.rectForRow(at: indexPath)
            return SFSafariViewController.instance(for: post.url, previewActionItemsDelegate: self)
        }
        return nil
    }

    func previewingContext(_ previewingContext: UIViewControllerPreviewing,
                           commit viewControllerToCommit: UIViewController) {
        present(viewControllerToCommit, animated: true, completion: nil)
    }

    func safariViewControllerPreviewActionItems(_ controller: SFSafariViewController) -> [UIPreviewActionItem] {
        guard let indexPath = peekedIndexPath else {
            return [UIPreviewActionItem]()
        }

        let post = posts[indexPath.row]
        let commentsPreviewActionTitle = post.commentsCount > 0 ?
            "View \(post.commentsCount) comments" : "View comments"

        let viewCommentsPreviewAction =
            UIPreviewAction(title: commentsPreviewActionTitle,
                            style: .default) { [unowned self, indexPath = indexPath] (_, _) -> Void in
            self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            self.navigateToComments()
        }
        return [viewCommentsPreviewAction]
    }
}

extension FeedViewController: Themed {
    func applyTheme(_ theme: AppTheme) {
        view.backgroundColor = theme.backgroundColor
        tableView.backgroundColor = theme.backgroundColor
        tableView.separatorColor = theme.separatorColor
        tableView.refreshControl?.tintColor = theme.appTintColor
        overrideUserInterfaceStyle = theme.userInterfaceStyle
    }
}
