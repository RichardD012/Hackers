//
//  UserSettings.swift
//  Hackers
//
//  Created by Weiran Zhang on 14/10/2017.
//  Copyright © 2017 Glass Umbrella. All rights reserved.
//

public enum ThemeType: Int {
    case Normal = 0
    case Dark = 1
    case Automatic = 999
}

@objc public class UserSettings: NSObject {
    @objc public dynamic var isDarkThemeEnabled = false
    @objc public dynamic var isAutomaticDarkThemeSelectionEnabled = false
    
    override init() {
        super.init()
        
        forEachSetting { key in
            self.addObserver(self, forKeyPath: key, options: .new, context: nil)
        }
    }
    
    deinit {
        forEachSetting { key in
            self.removeObserver(self, forKeyPath: key)
        }
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        var found = false
        
        forEachSetting { key in
            if key == keyPath {
                UserDefaults.standard.set(change?[NSKeyValueChangeKey.newKey], forKey: key)
                found = true
            }
        }
        
        if !found {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    fileprivate func forEachSetting(_ body: (_ key: String) -> Void) {
        for child in Mirror(reflecting: self).children {
            guard let key = child.label else { continue }
            body(key)
        }
    }
}
