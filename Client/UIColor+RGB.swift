//
//  UIColor+RGB.swift
//  Hackers
//
//  Created by Weiran Zhang on 08/10/2017.
//  Copyright © 2017 Glass Umbrella. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(_ rgb: Int) {
        self.init(rgb: rgb, alpha: 1.0)
    }
    
    convenience init(rgb: Int, alpha: CGFloat) {
        let red = CGFloat(rgb >> 16) / 255.0
        let green = CGFloat(rgb >> 8 & 0xff) / 255.0
        let blue = CGFloat(rgb >> 0 & 0xff) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
