//
//  Theme.swift
//  Hackers
//
//  Created by Weiran Zhang on 14/12/2015.
//  Copyright © 2015 Glass Umbrella. All rights reserved.
//

import UIKit

struct AppTheme {
    var appTintColor: UIColor //overall app tint overlay color
    var tabBarTintColor: UIColor //tint/overlay for tab bar
    var statusBarStyle: UIStatusBarStyle

    var backgroundColor: UIColor //main table background color
    var tabBarBackgroundColor: UIColor //tab bar background color
    var tabBarOpaque: Bool
    var tabBarTranslucent: Bool
    var navBarBackgroundColor: UIColor //nav bar background color
    var navBarTintColor: UIColor //tint/overlay for nav bar
    var navBarTranslucent: Bool
    var navBarOpaque: Bool
    var iconHidden: Bool
    var alternateIcons: Bool
    var hideMenuText: Bool
    var alternatePostCellLayout: Bool

    var titleTextColor: UIColor
    var visitedTitleTextColor: UIColor
    var postTitleDomainColor: UIColor
    var textColor: UIColor
    var metaDataTextColor: UIColor
    var lightTextColor: UIColor

    var cellHighlightColor: UIColor
    var cellBackgroundColor: UIColor
    var separatorColor: UIColor
    var commentLabelTintColor: UIColor
    var largeCommentTintColor: UIColor

    var groupedTableViewBackgroundColor: UIColor
    var groupedTableViewCellBackgroundColor: UIColor

    var upvotedColor: UIColor

    var userInterfaceStyle: UIUserInterfaceStyle
    var showHairline: Bool
    var hairlineColor: UIColor
}

extension AppTheme {
    private static let appTintColorLight = UIColor(rgb: 0x6513E5)
    private static let appTintColorDark = UIColor(rgb: 0xA06FED)
    private static let appTintColorDarkClassic = UIColor(red: 255/255.0, green: 102/255.0, blue: 0/255.0, alpha: 1)

    static let light = AppTheme(
        appTintColor: appTintColorLight,
        tabBarTintColor: appTintColorLight,
        statusBarStyle: .darkContent,

        backgroundColor: .white,
        tabBarBackgroundColor: .white,
        tabBarOpaque: true,
        tabBarTranslucent: false,
        navBarBackgroundColor: .white,
        navBarTintColor: appTintColorLight,
        navBarTranslucent: true,
        navBarOpaque: false,
        iconHidden: false,
        alternateIcons: false,
        hideMenuText: false,
        alternatePostCellLayout: false,
        titleTextColor: .black,
        visitedTitleTextColor: .black,
        postTitleDomainColor: .black,
        textColor: UIColor(rgb: 0x555555),
        metaDataTextColor: UIColor(rgb: 0x555555),
        lightTextColor: UIColor(rgb: 0xAAAAAA),

        cellHighlightColor: UIColor(rgb: 0xF4D1F2),
        cellBackgroundColor: .white,
        separatorColor: UIColor(rgb: 0xCACACA),
        commentLabelTintColor: .black,
        largeCommentTintColor: .black,

        groupedTableViewBackgroundColor: UIColor(rgb: 0xF2F2F7),
        groupedTableViewCellBackgroundColor: .white,

        upvotedColor: UIColor(rgb: 0xFF9300),

        userInterfaceStyle: .light,
        showHairline: false,
        hairlineColor: .clear
    )

    static let dark = AppTheme(
        appTintColor: appTintColorDark,
        tabBarTintColor: appTintColorDark,
        statusBarStyle: .lightContent,

        backgroundColor: .black,
        tabBarBackgroundColor: .black,
        tabBarOpaque: false,
        tabBarTranslucent: true,
        navBarBackgroundColor: .black,
        navBarTintColor: appTintColorDark,
        navBarTranslucent: true,
        navBarOpaque: false,
        iconHidden: false,
        alternateIcons: false,
        hideMenuText: false,
        alternatePostCellLayout: false,
        titleTextColor: UIColor(rgb: 0xDDDDDD),
        visitedTitleTextColor: UIColor(rgb: 0xDDDDDD),
        postTitleDomainColor: UIColor(rgb: 0xDDDDDD),
        textColor: UIColor(rgb: 0xAAAAAA),
        metaDataTextColor: UIColor(rgb: 0xAAAAAA),
        lightTextColor: UIColor(rgb: 0x555555),

        cellHighlightColor: UIColor(rgb: 0x34363D),
        cellBackgroundColor: .black,
        separatorColor: UIColor(rgb: 0x757575),
        commentLabelTintColor: UIColor(rgb: 0xDDDDDD),
        largeCommentTintColor: UIColor(rgb: 0xDDDDDD),

        // these are colours for a presented VC
        groupedTableViewBackgroundColor: UIColor(rgb: 0x1c1c1e),
        groupedTableViewCellBackgroundColor: UIColor(rgb: 0x2c2c2e),

        upvotedColor: UIColor(rgb: 0xFF9300),

        userInterfaceStyle: .dark,
        showHairline: false,
        hairlineColor: .clear
    )

    static let lightClassic = AppTheme(
        appTintColor: .black,
        tabBarTintColor: UIColor(red: 255/255.0, green: 102/255.0, blue: 0/255.0, alpha: 1),

        statusBarStyle: .darkContent,
        backgroundColor: .white,
        tabBarBackgroundColor: UIColor(red: 246/255.0, green: 246/255.0, blue: 239/255.0, alpha: 1),
        tabBarOpaque: true,
        tabBarTranslucent: false,
        navBarBackgroundColor: UIColor(red: 255/255.0, green: 102/255.0, blue: 0/255.0, alpha: 1),
        navBarTintColor: .black,
        navBarTranslucent: false,
        navBarOpaque: true,
        iconHidden: true,
        alternateIcons: true,
        hideMenuText: true,
        alternatePostCellLayout: true,
        titleTextColor: .black,
        visitedTitleTextColor: UIColor(red: 130/255.0, green: 130/255.0, blue: 130/255.0, alpha: 1),
        postTitleDomainColor: UIColor(red: 170/255.0, green: 170/255.0, blue: 170/255.0, alpha: 1),
        textColor: UIColor(rgb: 0x555555),
        metaDataTextColor: UIColor(rgb: 0x555555),
        lightTextColor: UIColor(rgb: 0xAAAAAA),

        cellHighlightColor: UIColor(red: 245/255.0, green: 245/255.0, blue: 242/255.0, alpha: 1),
        cellBackgroundColor: .white,
        separatorColor: UIColor(rgb: 0xCACACA),
        commentLabelTintColor: appTintColorDarkClassic,
        largeCommentTintColor: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1),

        groupedTableViewBackgroundColor: UIColor(rgb: 0xF2F2F7),
        groupedTableViewCellBackgroundColor: .white,

        upvotedColor: UIColor(rgb: 0xFF9300),

        userInterfaceStyle: .light,
        showHairline: true,
        hairlineColor: .lightGray
    )

    static let darkClassic = AppTheme(
        appTintColor: appTintColorDarkClassic,
        tabBarTintColor: appTintColorDarkClassic,
        statusBarStyle: .lightContent,

        backgroundColor: UIColor(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1),
        tabBarBackgroundColor: UIColor(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1),
        tabBarOpaque: true,
        tabBarTranslucent: false,
        navBarBackgroundColor: UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1),
        navBarTintColor: appTintColorDarkClassic,
        navBarTranslucent: false,
        navBarOpaque: true,
        iconHidden: true,
        alternateIcons: true,
        hideMenuText: true,
        alternatePostCellLayout: true,
        titleTextColor: UIColor(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1),
        visitedTitleTextColor: UIColor(red: 115/255.0, green: 115/255.0, blue: 115/255.0, alpha: 1),
        postTitleDomainColor: UIColor(red: 115/255.0, green: 115/255.0, blue: 115/255.0, alpha: 1),
        textColor: UIColor(rgb: 0xAAAAAA),
        metaDataTextColor: UIColor(red: 151/255.0, green: 151/255.0, blue: 151/255.0, alpha: 1),
        lightTextColor: UIColor(rgb: 0x555555),
        cellHighlightColor: UIColor(rgb: 0x34363D),
        cellBackgroundColor: UIColor(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1),
        separatorColor: UIColor(red: 56/255.0, green: 56/255.0, blue: 56/255.0, alpha: 1),
        commentLabelTintColor: appTintColorDarkClassic,
        largeCommentTintColor: UIColor(red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1),

        // these are colours for a presented VC
        groupedTableViewBackgroundColor: UIColor(rgb: 0x1c1c1e),
        groupedTableViewCellBackgroundColor: UIColor(rgb: 0x2c2c2e),

        upvotedColor: UIColor(rgb: 0xFF9300),

        userInterfaceStyle: .dark,
        showHairline: true,
        hairlineColor: .black
    )
}
