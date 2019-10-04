//
//  AppThemeProvider.swift
//  Night Mode
//
//  Created by Michael on 01/04/2018.
//  Copyright © 2018 Late Night Swift. All rights reserved.
//

import UIKit

final class AppThemeProvider: ThemeProvider {
    static let shared: AppThemeProvider = .init()

    private var theme: SubscribableValue<AppTheme>
    private var availableThemes: [AppTheme] = [.light, .dark, .darkClassic, .lightClassic]

    var currentTheme: AppTheme {
        get {
            return theme.value
        }
        set {
            setNewTheme(newValue)
        }
    }

    init() {
        theme = SubscribableValue<AppTheme>(value: .light)
    }

    private func setNewTheme(_ newTheme: AppTheme) {
        let window = UIApplication.shared.delegate!.window!!
        UIView.transition(
            with: window,
            duration: 0.3,
            options: [UIView.AnimationOptions.transitionCrossDissolve],
            animations: {
                self.theme.value = newTheme
            }
        )
    }

    func subscribeToChanges(_ object: AnyObject, handler: @escaping (AppTheme) -> Void) {
        theme.subscribe(object, using: handler)
    }

    public static func setupUIColors(navigationBar: UINavigationBar, for theme: AppTheme) {
        navigationBar.backgroundColor = theme.navBarBackgroundColor
        navigationBar.barTintColor = theme.navBarBackgroundColor
        navigationBar.tintColor = theme.navBarTintColor
        navigationBar.isTranslucent = theme.navBarTranslucent
        navigationBar.isOpaque = theme.navBarOpaque
    }

    public static func setupUIColors(tabBar: UITabBar, for theme: AppTheme) {
        tabBar.backgroundColor = theme.tabBarBackgroundColor
        tabBar.tintColor = theme.tabBarTintColor
        tabBar.isOpaque = theme.tabBarOpaque
        //tabBar.tintColor = AppThemeProvider.shared.currentTheme.tabBarTintColor
        //tabBar.isTranslucent = false
        //tabBar.isOpaque = true
        //tabBar.barTintColor = AppThemeProvider.shared.currentTheme.tabBarBackgroundColor
        //tabBar.unselectedItemTintColor = Theme.tabBarTextColor
    }
    
}

extension Themed where Self: AnyObject {
    var themeProvider: AppThemeProvider {
        return AppThemeProvider.shared
    }
}
