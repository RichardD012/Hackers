//
//  Theme.swift
//  Hackers
//
//  Created by Weiran Zhang on 14/12/2015.
//  Copyright © 2015 Glass Umbrella. All rights reserved.
//

import UIKit

struct AppTheme {
    var appTintColor: UIColor

    var statusBarStyle: UIStatusBarStyle

    var backgroundColor: UIColor
    var iconHidden: Bool
    var alternateIcons: Bool
    var hideMenuText: Bool
    var alternatePostCellLayout: Bool

    var titleTextColor: UIColor
    var postTitleDomainColor: UIColor
    var textColor: UIColor
    var metaDataTextColor: UIColor
    var lightTextColor: UIColor

    var cellHighlightColor: UIColor
    var cellBackgroundColor: UIColor
    var separatorColor: UIColor
    var largeCommentTintColor: UIColor

    var groupedTableViewBackgroundColor: UIColor
    var groupedTableViewCellBackgroundColor: UIColor

    var upvotedColor: UIColor

    var userInterfaceStyle: UIUserInterfaceStyle
}

extension AppTheme {
    private static let appTintColorLight = UIColor(rgb: 0x6513E5)
    private static let appTintColorDark = UIColor(rgb: 0xA06FED)
    private static let appTintColorDarkClassic = UIColor(red: 255/255.0, green: 102/255.0, blue: 0/255.0, alpha: 1)

    static let light = AppTheme(
        appTintColor: appTintColorLight,

        statusBarStyle: .darkContent,

        backgroundColor: .white,
        iconHidden: false,
        alternateIcons: false,
        hideMenuText: false,
        alternatePostCellLayout: false,
        titleTextColor: .black,
        postTitleDomainColor: .black,
        textColor: UIColor(rgb: 0x555555),
        metaDataTextColor: UIColor(rgb: 0x555555),
        lightTextColor: UIColor(rgb: 0xAAAAAA),

        cellHighlightColor: UIColor(rgb: 0xF4D1F2),
        cellBackgroundColor: .white,
        separatorColor: UIColor(rgb: 0xCACACA),
        largeCommentTintColor: .black,

        groupedTableViewBackgroundColor: UIColor(rgb: 0xF2F2F7),
        groupedTableViewCellBackgroundColor: .white,

        upvotedColor: UIColor(rgb: 0xFF9300),

        userInterfaceStyle: .light
    )

    static let dark = AppTheme(
        appTintColor: appTintColorDark,

        statusBarStyle: .lightContent,

        backgroundColor: .black,
        iconHidden: false,
        alternateIcons: false,
        hideMenuText: false,
        alternatePostCellLayout: false,
        titleTextColor: UIColor(rgb: 0xDDDDDD),
        postTitleDomainColor: UIColor(rgb: 0xDDDDDD),
        textColor: UIColor(rgb: 0xAAAAAA),
        metaDataTextColor: UIColor(rgb: 0xAAAAAA),
        lightTextColor: UIColor(rgb: 0x555555),

        cellHighlightColor: UIColor(rgb: 0x34363D),
        cellBackgroundColor: .black,
        separatorColor: UIColor(rgb: 0x757575),
        largeCommentTintColor: UIColor(rgb: 0xDDDDDD),

        // these are colours for a presented VC
        groupedTableViewBackgroundColor: UIColor(rgb: 0x1c1c1e),
        groupedTableViewCellBackgroundColor: UIColor(rgb: 0x2c2c2e),

        upvotedColor: UIColor(rgb: 0xFF9300),

        userInterfaceStyle: .dark
    )

    static let lightClassic = AppTheme(
        appTintColor: appTintColorLight,

        statusBarStyle: .darkContent,

        backgroundColor: .white,
        iconHidden: true,
        alternateIcons: false,
        hideMenuText: false,
        alternatePostCellLayout: true,
        titleTextColor: .black,
        postTitleDomainColor: .black,
        textColor: UIColor(rgb: 0x555555),
        metaDataTextColor: UIColor(rgb: 0x555555),
        lightTextColor: UIColor(rgb: 0xAAAAAA),

        cellHighlightColor: UIColor(rgb: 0xF4D1F2),
        cellBackgroundColor: .white,
        separatorColor: UIColor(rgb: 0xCACACA),
        largeCommentTintColor: .black,

        groupedTableViewBackgroundColor: UIColor(rgb: 0xF2F2F7),
        groupedTableViewCellBackgroundColor: .white,

        upvotedColor: UIColor(rgb: 0xFF9300),

        userInterfaceStyle: .light
    )

    static let darkClassic = AppTheme(
        appTintColor: appTintColorDarkClassic,

        statusBarStyle: .lightContent,

        backgroundColor: UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1),
        iconHidden: true,
        alternateIcons: true,
        hideMenuText: true,
        alternatePostCellLayout: true,
        titleTextColor: UIColor(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1),
        postTitleDomainColor: UIColor(red: 115/255.0, green: 115/255.0, blue: 115/255.0, alpha: 1),
        textColor: UIColor(rgb: 0xAAAAAA),
        metaDataTextColor: UIColor(red: 151/255.0, green: 151/255.0, blue: 151/255.0, alpha: 1),
        lightTextColor: UIColor(rgb: 0x555555),
        cellHighlightColor: UIColor(rgb: 0x34363D),
        cellBackgroundColor: UIColor(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1),
        separatorColor: UIColor(red: 56/255.0, green: 56/255.0, blue: 56/255.0, alpha: 1),
        largeCommentTintColor: UIColor(red: 70/255.0, green: 70/255.0, blue: 70/255.0, alpha: 1),

        // these are colours for a presented VC
        groupedTableViewBackgroundColor: UIColor(rgb: 0x1c1c1e),
        groupedTableViewCellBackgroundColor: UIColor(rgb: 0x2c2c2e),

        upvotedColor: UIColor(rgb: 0xFF9300),

        userInterfaceStyle: .dark
    )
}
