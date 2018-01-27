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
    private static var _isDarkMode = false
    static var isDarkMode : Bool{
        set {
            _isDarkMode = newValue
            NotificationCenter.default.post(name: .themeChanged, object: nil)
        }
        get { return _isDarkMode }
    }
    static let primaryOrangeColor = UIColor(red: 255/255.0, green: 102/255.0, blue: 0/255.0, alpha: 1)
    static let primaryDarkModeText = UIColor(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1)
    
    static var metaDataColor: UIColor {
        get {
            if(isDarkMode)
            {
                return UIColor(red: 151/255.0, green: 151/255.0, blue: 151/255.0, alpha: 1)
            }
            else{
                return UIColor(red: 130/255.0, green: 130/255.0, blue: 130/255.0, alpha: 1)
            }
        }
    }
    
    static var visitedLinkColor: UIColor {
        get {
            if(isDarkMode)
            {
                return UIColor(red: 115/255.0, green: 115/255.0, blue: 115/255.0, alpha: 1)
            }
            else{
                return UIColor(red: 130/255.0, green: 130/255.0, blue: 130/255.0, alpha: 1)
            }
            
        }
    }
    
    static var unvisitedLinkColor: UIColor {
        get {
            if(isDarkMode)
            {
                return primaryDarkModeText
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
                return UIColor(red: 115/255.0, green: 115/255.0, blue: 115/255.0, alpha: 1)
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
                return UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
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
                return primaryDarkModeText
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
                return UIColor.black
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
                return UIColor(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1)
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
                return primaryDarkModeText
            }
            else{
                return UIColor(red: 130/255.0, green: 130/255.0, blue: 130/255.0, alpha: 1)
            }
            
        }
    }
    
    static var skeletonBaseColor: UIColor {
        get {
            if(isDarkMode)
            {
                return UIColor(red: 115/255.0, green: 115/255.0, blue: 115/255.0, alpha: 1)
            }
            else{
                return UIColor.lightGray
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
                return  UIColor.black
            }
            else{
                return UIColor(red: 234/255.0, green: 234/255.0, blue: 234/255.0, alpha: 1)
            }
            
        }
    }
    
    static var commentAuthorTextColor: UIColor {
        get {
            if(isDarkMode)
            {
                return primaryDarkModeText
            }
            else{
                return UIColor.darkGray
            }
            
        }
    }
    
    static var commentTimeTextColor: UIColor {
        get {
            if(isDarkMode)
            {
                return UIColor(red: 151/255.0, green: 151/255.0, blue: 151/255.0, alpha: 1)
            }
            else{
                return UIColor(red: 130/255.0, green: 130/255.0, blue: 130/255.0, alpha: 1)
            }
        }
    }
    
    static var commentsTextColor: UIColor {
        get {
            if(isDarkMode)
            {
                return primaryDarkModeText
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
                return primaryOrangeColor
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
                return UIColor(red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1)
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
                return UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
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
                return UIColor(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1)
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
                return UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
            }
            else{
                return UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1)
            }
            
        }
    }
    
    static var tableSeparatorColor: UIColor {
        get {
            if(isDarkMode)
            {
                return UIColor(red: 56/255.0, green: 56/255.0, blue: 56/255.0, alpha: 1)
            }
            else{
                return UIColor(red: 234/255.0, green: 234/255.0, blue: 234/255.0, alpha: 1)
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
                return UIColor(red: 130/255.0, green: 130/255.0, blue: 130/255.0, alpha: 1)
            }
            else{
                return UIColor(red: 130/255.0, green: 130/255.0, blue: 130/255.0, alpha: 1)
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
    
    static var darkViewSwitchTintColor: UIColor? {
        get {
            if(isDarkMode)
            {
                return UIColor(red: 50/255.0, green: 50/255.0, blue: 50/255.0, alpha: 1)
            }
            else{
                return nil
            }
            
        }
    }
    
    static var darkViewSwitchThumbTintColor: UIColor? {
        get {
            if(isDarkMode)
            {
                return UIColor(red: 147/255.0, green: 147/255.0, blue: 147/255.0, alpha: 1)
            }
            else{
                return nil
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

        setStatusBarColors()
        UITabBar.appearance().tintColor = Theme.tabBarSelectedTextColor
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().isOpaque = true
        UITabBar.appearance().barTintColor = Theme.tabBarBackgroundColor
        UITabBar.appearance().unselectedItemTintColor = Theme.tabBarTextColor
        
        //UINavigationBar.appearance().isTranslucent = false
       // UINavigationBar.appearance().isOpaque = true
        
        UINavigationBar.appearance().backgroundColor = Theme.navigationBarBackgroundColor
        UINavigationBar.appearance().barTintColor = Theme.navigationBarBackgroundColor
        UINavigationBar.appearance().tintColor = Theme.navigationBarTextColor
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: Theme.navigationBarTextColor]
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: Theme.navigationBarTextColor]
        
        UIRefreshControl.appearance().tintColor = Theme.navigationBarTextColor
        
        UITableView.appearance().backgroundColor = Theme.tableBackgroundColor
        UITableView.appearance().separatorColor = Theme.tableSeparatorColor
        
    }
    
    static func setupUIColors(tableView: UITableView) {
        
        tableView.backgroundColor = Theme.tableBackgroundColor
        tableView.separatorColor = Theme.tableSeparatorColor
        
    }
    
    static func setupUIColors(tabBar: UITabBar) {
        
        
        tabBar.tintColor = Theme.tabBarSelectedTextColor
        tabBar.isTranslucent = false
        tabBar.isOpaque = true
        tabBar.barTintColor = Theme.tabBarBackgroundColor
        tabBar.unselectedItemTintColor = Theme.tabBarTextColor
    }
    
    
    static func setupUIColors(navigationBar: UINavigationBar) {
        
        setStatusBarColors()
        navigationBar.isTranslucent = false
        navigationBar.isOpaque = true
        navigationBar.backgroundColor = Theme.navigationBarBackgroundColor
        navigationBar.barTintColor = Theme.navigationBarBackgroundColor
        navigationBar.tintColor = Theme.navigationBarTextColor
        navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: Theme.navigationBarTextColor]
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: Theme.navigationBarTextColor]
    }
    
    static func setStatusBarColors()
    {
        if(isDarkMode)
        {
            UIApplication.shared.statusBarStyle = .lightContent
        }
        else
        {
            UIApplication.shared.statusBarStyle = .default
        }
    }
}
