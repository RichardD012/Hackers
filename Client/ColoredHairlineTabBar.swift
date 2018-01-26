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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(themeChanged(_:)), name: .themeChanged, object: nil)

    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(self, selector: #selector(themeChanged(_:)), name: .themeChanged, object: nil)

    }
    
    @objc private func themeChanged(_ notification: Notification) {
        hairline?.backgroundColor = Theme.tabBarHairlineColor
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .themeChanged, object: nil)
    }
    
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

