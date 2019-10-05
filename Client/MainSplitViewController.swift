//
//  MainSplitViewController.swift
//  Hackers
//
//  Created by Weiran Zhang on 01/02/2015.
//  Copyright (c) 2015 Glass Umbrella. All rights reserved.
//

import UIKit

class MainSplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTheming()
        delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        preferredDisplayMode = .allVisible
    }

    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        // only collapse the secondary onto the primary when it's the placeholder view
        return secondaryViewController is EmptyViewController
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return AppThemeProvider.shared.currentTheme.statusBarStyle
    }
}

extension MainSplitViewController: Themed {
    // Using the MainSplitViewController as a place to handle global theme changes - this doesn't update active views
    open func applyTheme(_ theme: AppTheme) {
        self.view.backgroundColor = .clear
        UITextView.appearance().tintColor = theme.appTintColor
        UITabBar.appearance().backgroundColor = theme.tabBarBackgroundColor
        UITabBar.appearance().tintColor = theme.tabBarTintColor
        UITabBar.appearance().isTranslucent = theme.tabBarTranslucent
        UITabBar.appearance().isOpaque = theme.tabBarOpaque
        UINavigationBar.appearance().tintColor = theme.navBarTintColor
    }
}
