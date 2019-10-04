//
//  MainTabBarController.swift
//  Hackers
//
//  Created by Weiran Zhang on 10/09/2017.
//  Copyright © 2017 Glass Umbrella. All rights reserved.
//

import UIKit
import HNScraper

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTheming()

        guard let viewControllers = viewControllers else { return }
        let theme = AppThemeProvider.shared.currentTheme
        for (index, viewController) in viewControllers.enumerated() {
            guard let splitViewController = viewController as? UISplitViewController,
                let navigationController = splitViewController.viewControllers.first as? UINavigationController,
                let newsViewController = navigationController.viewControllers.first as? NewsViewController
                else { return }
            
            if let tabItem = self.tabItem(for: index, theme: theme) {
                newsViewController.postType = tabItem.postType
                if theme.hideMenuText == false {
                    splitViewController.tabBarItem.title = tabItem.typeName
                    splitViewController.tabBarItem.image = UIImage(systemName: tabItem.iconName)
                } else {
                    splitViewController.tabBarItem.title = ""
                    splitViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
                    splitViewController.tabBarItem.image = UIImage(named: tabItem.iconName)
                }
            }
        }

        tabBar.clipsToBounds = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let viewController = OnboardingService.onboardingViewController() {
            present(viewController, animated: true)
        }
    }

    private func tabItem(for index: Int, theme: AppTheme) -> TabItem? {
        if theme.alternateIcons {
            return altTabItem(for: index)
        } else {
           return tabItem(for: index)
        }
    }
    private func altTabItem(for index: Int) -> TabItem? {
        switch index {
        case 0:
            return TabItem(postType: .news, typeName: "Top", iconName: "TopIcon")
        case 1:
            return TabItem(postType: .asks, typeName: "Ask", iconName: "AskIcon")
        case 2:
            return TabItem(postType: .jobs, typeName: "Jobs", iconName: "ProfileIcon") //TODO: Update This icon
        case 3:
            return TabItem(postType: .new, typeName: "New", iconName: "NewIcon")
        default:
            return nil
        }
    }
    private func tabItem(for index: Int) -> TabItem? {
        switch index {
        case 0:
           return TabItem(postType: .news, typeName: "Top", iconName: "globe")
        case 1:
           return TabItem(postType: .asks, typeName: "Ask", iconName: "questionmark.circle")
        case 2:
           return TabItem(postType: .jobs, typeName: "Jobs", iconName: "briefcase")
        case 3:
           return TabItem(postType: .new, typeName: "New", iconName: "clock")
        default:
           return nil
       }
    }

    struct TabItem {
        let postType: HNScraper.PostListPageName
        let typeName: String
        let iconName: String
    }
}

extension MainTabBarController: Themed {
    func applyTheme(_ theme: AppTheme) {
        overrideUserInterfaceStyle = theme.userInterfaceStyle
        self.view.backgroundColor = theme.navBarBackgroundColor
        if self.tabBarController != nil {
            AppThemeProvider.setupUIColors(tabBar: self.tabBarController!.tabBar, for: theme)
        }
    }
}
