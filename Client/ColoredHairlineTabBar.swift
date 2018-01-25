//
//  ColoredHairlineTabBar.swift
//  TabBarHairline
//
//  Created by Leo Natan on 5/6/16.
//  Copyright © 2016 Leo Natan. All rights reserved.
//

import UIKit

@objc(LNColoredHairlineTabBar)
public class ColoredHairlineTabBar: UITabBar {
    private var hairline : UIView?
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if hairline == nil {
            hairline = UIView()
            hairline?.backgroundColor = Theme.tabBarHairlineColor
            addSubview(hairline!)
        }
        hairline?.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: bounds.width, height: 1 / UIScreen.main.scale))
        
        //Hide the original hairline.
        subviews.filter({ $0 is UIImageView }).forEach({ ($0 as! UIImageView).isHidden = true })
    }
}

