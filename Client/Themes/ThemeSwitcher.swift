//
//  ThemeSwitcher.swift
//  Hackers
//
//  Created by Weiran Zhang on 22/06/2019.
//  Copyright © 2019 Glass Umbrella. All rights reserved.
//

import UIKit

enum ThemeSwitcher {
    public static func switchTheme() {
        let settingsStore = SettingsStore()
        let theme = settingsStore.theme
        switchTheme(for: theme)
    }
    
    public static func switchTheme(for theme: SettingsStore.ThemeType) {
        switch (theme, UITraitCollection.current.userInterfaceStyle) {
        case (.darkClassic, _):
            AppThemeProvider.shared.currentTheme = .darkClassic
        case (.lightClassic, _):
            AppThemeProvider.shared.currentTheme = .lightClassic
        case (.dark, _), (.system, .dark):
            AppThemeProvider.shared.currentTheme = .dark
        case (.light, _), (.system, .light):
            AppThemeProvider.shared.currentTheme = .light
        default:
            AppThemeProvider.shared.currentTheme = .light
        }
    }
}
