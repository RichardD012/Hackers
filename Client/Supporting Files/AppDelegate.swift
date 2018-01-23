//
//  AppDelegate.swift
//  Hackers2
//
//  Created by Weiran Zhang on 07/06/2014.
//  Copyright (c) 2014 Glass Umbrella. All rights reserved.
//

import UIKit
import libHN

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        HNManager.shared().startSession()
        UITextView.appearance().tintColor = Theme.orangeColor
        UITabBar.appearance().tintColor = Theme.orangeColor
       //ReviewController.incrementLaunchCounter()
        //ReviewController.requestReview()
    }
}
