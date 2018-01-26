//
//  MainTabBarController.swift
//  Hackers
//
//  Created by Weiran Zhang on 10/09/2017.
//  Copyright © 2017 Glass Umbrella. All rights reserved.
//

import UIKit
import libHN

class MainTabBarController: UITabBarController {
    var firstLaunch = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewControllers = self.viewControllers else { return }
        
        for (index, viewController) in viewControllers.enumerated() {
            guard let navController = viewController as? UINavigationController else { continue }
            var iconName: String?
            switch index {
            case 1:
                iconName = "NewIcon"
                break
            case 2:
                iconName = "TopIcon"
                break
            case 3:
                iconName = "ProfileIcon"
                break
            case 4:
                iconName = "SettingsIcon"
                break
            case 0:
                fallthrough
            default:
                iconName = "AskIcon"
            }
            navController.tabBarItem.title = ""
            navController.tabBarItem.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
            navController.tabBarItem.image = UIImage(named: iconName!)
            //Theme.setupNavigationBar(navController.navigationBar)
            if let newsVC = navController.viewControllers.first as? NewsViewController {
                var viewTitle: String?
                var postType: PostFilterType?
                switch index {
                case 1:
                    postType = .new
                    viewTitle = "HN: Latest"
                    break
                case 2:
                    viewTitle = "Hacker News"
                    postType = .top
                    break
                case 0:
                    fallthrough
                default:
                    viewTitle = "Ask HN"
                    postType = .ask
                }
                newsVC.navigationItem.title = viewTitle
                //newsVC.tabBarItem.title = ""
                newsVC.postType = postType
            }
        }
        tabBar.clipsToBounds = true
        if(firstLaunch)
        {
            firstLaunch=false
            self.selectedIndex = 2 //default is 2/Top
        }
    }
}
