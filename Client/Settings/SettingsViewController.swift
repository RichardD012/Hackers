//
//  SettingsViewController.swift
//  Hackers
//
//  Created by Richard Dyer on 1/25/18.
//  Copyright © 2018 Glass Umbrella. All rights reserved.
//

import Foundation

class SettingsViewController : UIViewController {
    
    
    private var collapseDetailViewController = true
    private var peekedIndexPath: IndexPath?
    private var isProcessing: Bool = false
    private var viewIsUnderTransition = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //NotificationCenter.default.addObserver(self, selector: #selector(NewsViewController.viewDidRotate), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
    }
    
    override func awakeFromNib() {
        /*
         TODO: workaround for an iOS 11 bug: if prefersLargeTitles is set in storyboard,
         it never shrinks with scroll. When fixed, remove from code and set in storyboard.
         */
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.largeTitleDisplayMode = .always
    }
}

