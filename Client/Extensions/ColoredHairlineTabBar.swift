//
//  ColoredHairlineTabBar.swift
//  Hackers
//
//  Created by Richard Dyer on 10/5/19.
//  Copyright © 2019 Glass Umbrella. All rights reserved.
//

import Foundation
import UIKit

public class ColoredHairlineTabBar: UITabBar {
    private var hairline: UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @objc private func themeChanged(_ notification: Notification) {
        //hairline?.backgroundColor = Theme.tabBarHairlineColor
    }

    deinit {
        //NotificationCenter.default.removeObserver(self, name: .themeChanged, object: nil)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        if hairline == nil {
            hairline = UIView()
            hairline?.backgroundColor = .clear
            addSubview(hairline!)
        }
        hairline?.frame = CGRect(origin: CGPoint(x: 0, y: 0),
                                 size: CGSize(width: bounds.width, height: 1 / UIScreen.main.scale))
        setupTheming()
    }
}

extension ColoredHairlineTabBar: Themed {
    func applyTheme(_ theme: AppTheme) {
        if theme.showHairline {
            hairline?.backgroundColor = theme.hairlineColor
        } else {
            hairline?.backgroundColor = .clear
        }
    }
}
