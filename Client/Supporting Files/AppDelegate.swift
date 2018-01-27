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
        let isAutoTheme = DataPersistenceManager.isAutoTheme()
        let isDarkTheme = DataPersistenceManager.isDarkTheme()
        if(isAutoTheme == false && isDarkTheme )//or AutoTheme is on and below threshold
        {
            Theme.isDarkMode = true
        }else if (isAutoTheme)
        {
            let currentBrightness = Float(UIScreen.main.brightness)
            let sliderValue = DataPersistenceManager.autoThemeThreshold()
            if(currentBrightness <= sliderValue)
            {
                Theme.isDarkMode = true
            }else{
                Theme.isDarkMode = false
            }
        }
        Theme.setupUIColors()
        
    }
    
    /*func getImageWithColor(color: UIColor) -> UIImage
    {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 1.0, height: 1.0))
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }*/
}
