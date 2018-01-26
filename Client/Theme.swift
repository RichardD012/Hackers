//
//  Theme.swift
//  Hackers
//
//  Created by Weiran Zhang on 14/12/2015.
//  Copyright © 2015 Glass Umbrella. All rights reserved.
//

import Foundation
import UIKit

struct Theme {
    static var isDarkMode = false
    static let primaryOrangeColor = UIColor(red: 255/255.0, green: 102/255.0, blue: 0/255.0, alpha: 1)//#ff6600
    
    
    static var metaDataColor: UIColor {
        get {
            if(isDarkMode)
            {
                return UIColor.blue
            }
            else{
                return UIColor(red: 130/255.0, green: 130/255.0, blue: 130/255.0, alpha: 1) //#828282
            }
            
        }
    }
    
    static var visitedLinkColor: UIColor {
        get {
            if(isDarkMode)
            {
                return UIColor.green
            }
            else{
                return UIColor(red: 130/255.0, green: 130/255.0, blue: 130/255.0, alpha: 1) //#828282
            }
            
        }
    }
    
    static var unvisitedLinkColor: UIColor {
        get {
            if(isDarkMode)
            {
                return UIColor.white
            }
            else{
                return UIColor.black
            }
            
        }
    }
    
    
    
    static var postTitleDomainColor: UIColor {
        get {
            if(isDarkMode)
            {
                return UIColor.red
            }
            else{
                return UIColor(red: 170/255.0, green: 170/255.0, blue: 170/255.0, alpha: 1)
            }
            
        }
    }
    
    static var navigationBarBackgroundColor: UIColor {
        get {
            if(isDarkMode)
            {
                return primaryOrangeColor
            }
            else{
                return primaryOrangeColor
            }
            
        }
    }
    
    
    static var navigationBarTextColor: UIColor {
        get {
            if(isDarkMode)
            {
                return UIColor.black
            }
            else{
                return UIColor.black
            }
            
        }
    }
    
    static var tabBarHairlineColor: UIColor {
        get {
            if(isDarkMode)
            {
                return UIColor.lightGray
            }
            else{
                return UIColor.lightGray
            }
            
        }
    }
    
   
    static var tabBarBackgroundColor: UIColor {
        get {
            if(isDarkMode)
            {
                return UIColor.black
            }
            else{
                return UIColor(red: 246/255.0, green: 246/255.0, blue: 239/255.0, alpha: 1)
            }
            
        }
    }
    
    static var tabBarTextColor: UIColor {
        get {
            if(isDarkMode)
            {
                return UIColor(red: 130/255.0, green: 130/255.0, blue: 130/255.0, alpha: 1) //#828282
            }
            else{
                return UIColor(red: 190/255.0, green: 190/255.0, blue: 190/255.0, alpha: 1) //#828282
            }
            
        }
    }
    
    
    static var tabBarSelectedTextColor: UIColor {
        get {
            if(isDarkMode)
            {
                return primaryOrangeColor
            }
            else{
                return primaryOrangeColor
            }
            
        }
    }
    
    static var commentsViewPostSeparatorColor: UIColor {
        get {
            if(isDarkMode)
            {
                return UIColor.lightGray
            }
            else{
                return UIColor.lightGray
            }
            
        }
    }
    
    static var commentsTextColor: UIColor {
        get {
            if(isDarkMode)
            {
                return UIColor.darkGray
            }
            else{
                return UIColor.darkGray
            }
            
        }
    }
    
    
    static var commentIconTextColor: UIColor {
        get {
            if(isDarkMode)
            {
                return UIColor.red
            }
            else{
                return primaryOrangeColor
            }
            
        }
    }
    
    static var commentIconImageColor: UIColor {
        get {
            if(isDarkMode)
            {
                return UIColor.red
            }
            else{
                return UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)
            }
            
        }
    }
    
    static var selectedCellBackgroundColor: UIColor {
        get {
            if(isDarkMode)
            {
                return UIColor.red
            }
            else{
                return UIColor(red: 245/255.0, green: 245/255.0, blue: 242/255.0, alpha: 1)
            }
            
        }
    }
    
    static var unselectedCellBackgroundColor: UIColor {
        get {
            if(isDarkMode)
            {
                return UIColor.black
            }
            else{
                return UIColor.white
            }
            
        }
    }
    
    //Generic Table Settings values
    static var tableBackgroundColor: UIColor {
        get {
            if(isDarkMode)
            {
                return UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1)
            }
            else{
                return UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1)
            }
            
        }
    }
    
    static var tableSectionHeading: UIColor {
        get {
            if(isDarkMode)
            {
                return UIColor(red: 130/255.0, green: 130/255.0, blue: 130/255.0, alpha: 1)
            }
            else{
                return UIColor(red: 130/255.0, green: 130/255.0, blue: 130/255.0, alpha: 1)
            }
            
        }
    }
    
    //Settings values
    static var darkSliderMinimumTintColor: UIColor {
        get {
            if(isDarkMode)
            {
                return primaryOrangeColor
            }
            else{
                return primaryOrangeColor
            }
            
        }
    }
    
    static var themeCheckTintColor: UIColor {
        get {
            if(isDarkMode)
            {
                return primaryOrangeColor
            }
            else{
                return primaryOrangeColor
            }
            
        }
    }
    
    static var darkSliderMaximumTintColor: UIColor {
        get {
            if(isDarkMode)
            {
                return UIColor(red: 130/255.0, green: 130/255.0, blue: 130/255.0, alpha: 1) //#828282
            }
            else{
                return UIColor(red: 130/255.0, green: 130/255.0, blue: 130/255.0, alpha: 1) //#828282
            }
            
        }
    }
    

    static var settingsBrightnessIndicatorColor: UIColor {
        get {
            if(isDarkMode)
            {
                return primaryOrangeColor
            }
            else{
                return primaryOrangeColor
            }
            
        }
    }
    
    static var settingsBrightnessIndicatorStroke: UIColor {
        get {
            if(isDarkMode)
            {
                return UIColor.white
            }
            else{
                return UIColor.white
            }
            
        }
    }
    
    static var settingsMinimumSliderImage: String {
        get {
            if(isDarkMode)
            {
                return "MoonDark"
            }
            else{
                return "Moon"
            }
            
        }
    }
    
    static var settingsMaximumSliderImage: String {
        get {
            if(isDarkMode)
            {
                return "SunDark"
            }
            else{
                return "Sun"
            }
            
        }
    }
    
    static var darkViewSwitchOnColor: UIColor {
        get {
            if(isDarkMode)
            {
                return primaryOrangeColor
            }
            else{
                return primaryOrangeColor
            }
            
        }
    }
    
    static var settingsTextColor: UIColor {
        get {
            if(isDarkMode)
            {
                return UIColor.white
            }
            else{
                return UIColor.black
            }
            
        }
    }
    
    
    static func setupUIColors() {

        
        UITabBar.appearance().tintColor = Theme.tabBarSelectedTextColor
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().isOpaque = true
        UITabBar.appearance().barTintColor = Theme.tabBarBackgroundColor
        UITabBar.appearance().unselectedItemTintColor = Theme.tabBarTextColor
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().isOpaque = true
        UINavigationBar.appearance().backgroundColor = Theme.navigationBarBackgroundColor
        UINavigationBar.appearance().barTintColor = Theme.navigationBarBackgroundColor
        UINavigationBar.appearance().tintColor = Theme.navigationBarTextColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: Theme.navigationBarTextColor]
        UIRefreshControl.appearance().tintColor = Theme.navigationBarTextColor
        
        UITableView.appearance().backgroundColor = Theme.tableBackgroundColor
        
    }
}
