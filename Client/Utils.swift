//
//  Utils.swift
//  Hackers
//
//  Created by Richard Dyer on 2/2/18.
//  Copyright © 2018 Glass Umbrella. All rights reserved.
//

import Foundation
import SafariServices

public class Utils: NSObject {
    private var safariViewController: SFSafariViewController?
    public static func getSafariViewController(_ url: URL, previewDelegate: SFSafariViewControllerPreviewActionItemsDelegate? = nil) -> SFSafariViewController {
        let util = Utils()
        let safariVC = SFSafariViewController(url: url)
        if(previewDelegate != nil)
        {
            safariVC.previewActionItemsDelegate = previewDelegate
        }
        safariVC.preferredBarTintColor = Theme.safariTintColor

        //safariVC.delegate = util
        //NotificationCenter.default.addObserver(safariVC, selector: #selector(themeChanged(_:)), name: .themeChanged, object: nil)
        util.safariViewController = safariVC
        return safariVC
    }
    
   /* deinit {
        NotificationCenter.default.removeObserver(self, name: .themeChanged, object: nil)
    }
    
    @objc private func themeChanged(_ notification: Notification) {
       safariViewController?.preferredBarTintColor = Theme.safariTintColor
    }*/
    
}

/*extension Utils: SFSafariViewControllerDelegate {
    
    public func safariViewControllerDidFinish(_ controller: SFSafariViewController)
    {
        NotificationCenter.default.removeObserver(self, name: .themeChanged, object: nil)
    }
}*/
