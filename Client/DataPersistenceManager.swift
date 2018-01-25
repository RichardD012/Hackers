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
}
