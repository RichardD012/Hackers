//
//  UserDefaultsExtensions.swift
//  Hackers
//
//  Created by Weiran Zhang on 05/05/2018.
//  Copyright © 2018 Glass Umbrella. All rights reserved.
//

import Foundation

extension UserDefaults {
    /*public var darkModeEnabled: Bool {
        let themeSetting = string(forKey: UserDefaultsKeys.theme.rawValue)
        return themeSetting == "dark" || themeSetting == "darkClassic"
    }

    public func setDarkMode(_ enabled: Bool) {
        set(enabled ? "dark" : "light", forKey: UserDefaultsKeys.theme.rawValue) //TODO: Set it here
    }*/
    
   /* public func setTheme(_ theme: ThemeType) {
        set(enabled, forKey: UserDefaultsKeys.theme.rawValue)
    }*/
    
    public var safariReaderModeEnabled: Bool {
        let safariReaderModeSetting = bool(forKey: UserDefaultsKeys.safariReaderMode.rawValue)
        return safariReaderModeSetting
    }

    public func setSafariReaderMode(_ enabled: Bool) {
        set(enabled, forKey: UserDefaultsKeys.safariReaderMode.rawValue)
    }
}

enum UserDefaultsKeys: String {
    case theme
    case safariReaderMode
}
