//
//  DataPersistenceManager.swift
//  Hackers
//
//  Created by Richard Dyer on 1/25/18.
//  Copyright © 2018 Glass Umbrella. All rights reserved.
//

import Foundation
import libHN

class DataPersistenceManager {
    static let userDefaults = UserDefaults.standard
    static func hasVisited( post: HNPost ) -> Bool {
        return userDefaults.object(forKey: "post-\(post.postId)" ) != nil
    }
    
    static func setVisited( post: HNPost ) {
        let date = Date()
        userDefaults.set(date, forKey: "post-\(post.postId)" )
        userDefaults.synchronize()
    }
    
    static func setIsDarkTheme(darkMode: Bool){
        userDefaults.set(darkMode, forKey: "setting-darkTheme")
        userDefaults.synchronize()
    }
    
    static func setIsAutoTheme(autoTheme: Bool){
        userDefaults.set(autoTheme, forKey: "setting-autoTheme")
        userDefaults.synchronize()
    }
    
    static func setAutoTheme(threshold: Float){
        userDefaults.set(threshold, forKey: "setting-autoThreshold")
        userDefaults.synchronize()
    }
    
    static func autoThemeThreshold() -> Float {
        return userDefaults.float(forKey: "setting-autoThreshold" )
    }
    
    static func isDarkTheme() -> Bool {
        return userDefaults.bool(forKey: "setting-darkTheme" )
    }
    
    static func isAutoTheme() -> Bool {
        return userDefaults.bool(forKey: "setting-autoTheme" )
    }
}
