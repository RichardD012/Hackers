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
    static let purpleColour = UIColor(red: 101/255.0, green: 19/255.0, blue: 229/255.0, alpha: 1)
    static let backgroundPurpleColour = UIColor(red:0.879, green:0.816, blue:0.951, alpha:1)
    static let backgroundTintColor = UIColor(red:0.98, green:0.98, blue:0.998, alpha:1)
    
    static func setupNavigationBar(_ navigationBar: UINavigationBar) {
        navigationBar.barTintColor = backgroundTintColor
        navigationBar.tintColor = purpleColour
        //navigationBar.setValue(false, forKey: "hidesShadow")
    }
}
