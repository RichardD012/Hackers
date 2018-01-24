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
    //static let orangeColour = UIColor(red: 229/255.0, green: 149/255.0, blue: 59/255.0, alpha: 1)
    static let visitedLinkColor = UIColor(red: 130/255.0, green: 130/255.0, blue: 130/255.0, alpha: 1) //#828282
    static let selectedCellBackgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 242/255.0, alpha: 1)
    static let primaryOrangeColour = UIColor(red: 255/255.0, green: 102/255.0, blue: 0/255.0, alpha: 1)//#ff6600
    static let tabBarBackgroundColour = UIColor(red: 246/255.0, green: 246/255.0, blue: 239/255.0, alpha: 1)//#f6f6ef
    //static let backgroundTintColor = UIColor(red:0.98, green:0.98, blue:0.998, alpha:1)
    
    static func setupNavigationBar(_ navigationBar: UINavigationBar) {
        //navigationBar.barTintColor = primaryOrangeColour
        //navigationBar.tintColor = primaryOrangeColour
        //navigationBar.setValue(false, forKey: "hidesShadow")
    }
}
