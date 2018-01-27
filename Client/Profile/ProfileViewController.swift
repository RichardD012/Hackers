//
//  ProfileViewController.swift
//  Hackers
//
//  Created by Richard Dyer on 1/25/18.
//  Copyright © 2018 Glass Umbrella. All rights reserved.
//

import Foundation

class ProfileViewController : UIViewController {

    
    private var collapseDetailViewController = true
    private var peekedIndexPath: IndexPath?
    private var isProcessing: Bool = false
    private var viewIsUnderTransition = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTheme()
        NotificationCenter.default.addObserver(self, selector: #selector(themeChanged(_:)), name: .themeChanged, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(NewsViewController.viewDidRotate), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .themeChanged, object: nil)
    }
    
    @objc private func themeChanged(_ notification: Notification) {
        setupTheme()
    }
    
    func setupTheme(){
        self.view.backgroundColor = Theme.unselectedCellBackgroundColor
        if(self.navigationController != nil)
        {
            Theme.setupUIColors(navigationBar: self.navigationController!.navigationBar)
        }
        if(self.tabBarController != nil)
        {
            Theme.setupUIColors(tabBar: self.tabBarController!.tabBar)
        }
        /*self.darkViewSwitch.tintColor = Theme.darkViewSwitchThumbTintColor
        self.darkViewSwitch.thumbTintColor = Theme.darkViewSwitchThumbTintColor
        self.darkViewSwitch.onTintColor = Theme.darkViewSwitchOnColor
        self.lightCellLabel.textColor = Theme.settingsTextColor
        self.darkCellLabel.textColor = Theme.settingsTextColor
        self.autoThemeLabel.textColor = Theme.settingsTextColor
        self.darkModeSlider.minimumTrackTintColor = Theme.darkSliderMinimumTintColor
        self.darkModeSlider.maximumTrackTintColor = Theme.darkSliderMaximumTintColor
        
        self.lightCell.tintColor = Theme.themeCheckTintColor
        self.darkCell.tintColor = Theme.themeCheckTintColor
        Theme.setupUIColors(navigationBar: self.navigationController!.navigationBar, tabBar:self.tabBarController!.tabBar)
        Theme.setupUIColors(tableView: tableView)
        tableView.reloadData()*/
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

