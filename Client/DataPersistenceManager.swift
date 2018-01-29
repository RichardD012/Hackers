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
    static var hasLoaded = false
    static var postDictionary:[String:Date] = [String: Date]()
    
    static func initializePosts() {
        if(hasLoaded == false)
        {
            //load it
            hasLoaded = true
            /*let storedDictionary = UserDefaults.standard.value(forKey: "post-data") as? [String: Date]
            if(storedDictionary == nil)
            {
               postDictionary = [String: Date]()
            }else{
                postDictionary = storedDictionary!
            }*/
            guard let storedDictionary = UserDefaults.standard.value(forKey: "post-data") as? [String: Date] else {
                postDictionary = [String: Date]()
                return
            }
            postDictionary = storedDictionary
            let cutoff = Date().addingTimeInterval((-60*60*24*30)) //30 days
            var updates = false
            for (postId, date) in postDictionary {
                if(date<cutoff)
                {
                    updates = true
                    postDictionary.removeValue(forKey: postId)
                }
            }
            if(updates){
                userDefaults.set(postDictionary, forKey: "post-data")
                userDefaults.synchronize()
            }
        }
    }
    
    static func hasVisited( post: HNPost ) -> Bool {
        initializePosts()
        return postDictionary[post.postId!] != nil
    }
    
    static func setVisited( post: HNPost ) {
        initializePosts()
        let date = Date()
        postDictionary[post.postId!] = date
        //userDefaults.set(date, forKey: "post-\(post.postId)" )
        userDefaults.set(postDictionary, forKey: "post-data")
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
