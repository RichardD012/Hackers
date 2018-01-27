//
//  SettingsViewController.swift
//  Hackers
//
//  Created by Richard Dyer on 1/25/18.
//  Copyright © 2018 Glass Umbrella. All rights reserved.
//

import Foundation

class SettingsViewController : UITableViewController {
    
    var autoTheme = false
    //var shapeLayer: CALayer = nil
    @IBOutlet weak var darkModeSlider: UISlider!
    @IBOutlet weak var darkViewSwitch: UISwitch!
    @IBOutlet weak var lightCell: UITableViewCell!
    @IBOutlet weak var darkCell: UITableViewCell!
    
    @IBOutlet weak var lightCellLabel: UILabel!
    @IBOutlet weak var darkCellLabel: UILabel!
    @IBOutlet weak var sliderCell: UITableViewCell!
    
    @IBOutlet weak var autoThemeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTheme()
        setupDefaults()
        NotificationCenter.default.addObserver(self, selector: #selector(themeChanged(_:)), name: .themeChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(brightnessChanged(_:)), name: .UIScreenBrightnessDidChange, object: nil)
        darkCell?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDarkThemeButton(_:))))
        lightCell?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapLightThemeButton(_:))))
        setupBrightness()
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .themeChanged, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIScreenBrightnessDidChange, object: nil)
    }
    
    func setupBrightness()
    {

        sliderCell.layer.sublayers?.forEach {
            if( $0.name == "BrightnessDot"){
                $0.removeFromSuperlayer()
            }
        }
        let currentBrightness = UIScreen.main.brightness
        let radius: Float = 4.0
        let strokeWidth: Float = 1.0
        let lineWidth = darkModeSlider.frame.width - 80
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 40 + (lineWidth * currentBrightness),y: (sliderCell.frame.height/2) + CGFloat(strokeWidth)), radius: CGFloat(radius), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.name = "BrightnessDot"
        //change the fill color
        shapeLayer.fillColor = Theme.settingsBrightnessIndicatorColor.cgColor
        //you can change the stroke color
        shapeLayer.strokeColor = Theme.settingsBrightnessIndicatorStroke.cgColor
        //you can change the line width
        shapeLayer.lineWidth = CGFloat(strokeWidth*1.0)
        if let layerCount = sliderCell.layer.sublayers?.count {
            sliderCell.layer.insertSublayer(shapeLayer, at: UInt32(layerCount))
        }
    }
    
    @objc private func brightnessChanged(_ notification: Notification) {
        setupBrightness()
    }
    
    @objc private func themeChanged(_ notification: Notification) {
        setupTheme()
    }

    
    func setupDefaults()
    {
        let isAutoTheme = DataPersistenceManager.isAutoTheme()
        setAutoTheme(enabled: isAutoTheme)
        darkViewSwitch.isOn = isAutoTheme
        let isDarkTheme = DataPersistenceManager.isDarkTheme()
        setDarkTheme(darkTheme: isDarkTheme)
        let sliderValue = DataPersistenceManager.autoThemeThreshold()
        darkModeSlider.value = sliderValue
    }
    
    func setupTheme(){
        self.darkViewSwitch.tintColor = Theme.darkViewSwitchThumbTintColor
        self.darkViewSwitch.thumbTintColor = Theme.darkViewSwitchThumbTintColor
        self.darkViewSwitch.onTintColor = Theme.darkViewSwitchOnColor
        self.lightCellLabel.textColor = Theme.settingsTextColor
        self.darkCellLabel.textColor = Theme.settingsTextColor
        self.autoThemeLabel.textColor = Theme.settingsTextColor
        self.darkModeSlider.minimumTrackTintColor = Theme.darkSliderMinimumTintColor
        self.darkModeSlider.maximumTrackTintColor = Theme.darkSliderMaximumTintColor
        
        self.lightCell.tintColor = Theme.themeCheckTintColor
        self.darkCell.tintColor = Theme.themeCheckTintColor
        if(self.navigationController != nil)
        {
            Theme.setupUIColors(navigationBar: self.navigationController!.navigationBar)
        }
        if(self.tabBarController != nil)
        {
            Theme.setupUIColors(tabBar: self.tabBarController!.tabBar)
        }
        Theme.setupUIColors(tableView: tableView)
        tableView.reloadData()
    }
    
    
    @objc func didTapLightThemeButton(_ sender: Any) {
        if(autoTheme == false)
        {
            setDarkTheme(darkTheme: false)
            DataPersistenceManager.setIsDarkTheme(darkMode: false)
            handleCurrentTheme()
        }
    }
    
    @objc func didTapDarkThemeButton(_ sender: Any) {
        if(autoTheme == false)
        {
            setDarkTheme(darkTheme: true)
            DataPersistenceManager.setIsDarkTheme(darkMode: true)
            handleCurrentTheme()
        }
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
    
    override func tableView(_ tableView: UITableView,
                   willDisplayHeaderView view: UIView,
                   forSection section: Int)
    {
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.font = UIFont.boldSystemFont(ofSize: 12.0) // change it according to ur requirement
        header?.textLabel?.textColor = Theme.tableSectionHeading // change it according to ur requirement
    }
    
    override func tableView(_ tableView: UITableView,
                            willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath)
    {
        cell.backgroundColor = Theme.unselectedCellBackgroundColor
    }
    
    func handleCurrentTheme()
    {
        if(autoTheme)
        {
            let currentBrightness = Float(UIScreen.main.brightness)
            if(darkModeSlider.value <= currentBrightness)
            {
                if(Theme.isDarkMode == false)
                {
                    Theme.isDarkMode = true
                }
            }else
            {
                if(Theme.isDarkMode == true)
                {
                    Theme.isDarkMode = false
                }
            }
        }else
        {
            if(lightCell.accessoryType == UITableViewCellAccessoryType.checkmark)
            {
                if(Theme.isDarkMode)
                {
                    Theme.isDarkMode = false
                }
            }else{
                if(Theme.isDarkMode == false)
                {
                    Theme.isDarkMode = true
                }
            }
        }
    }
    
    @IBAction func darkViewSwitchChanged(_ sender: UISwitch) {
        setAutoTheme(enabled: sender.isOn)
        DataPersistenceManager.setIsAutoTheme(autoTheme: sender.isOn)
        handleCurrentTheme()
    }
    
    
    @IBAction func darkModeSliderChanged(_ sender: UISlider) {
        DataPersistenceManager.setAutoTheme(threshold: sender.value)
        handleCurrentTheme()
    }
    
    func setDarkTheme( darkTheme: Bool)
    {
        if(darkTheme)
        {
            lightCell.accessoryType = UITableViewCellAccessoryType.none
            darkCell.accessoryType = UITableViewCellAccessoryType.checkmark
        }else{

            lightCell.accessoryType = UITableViewCellAccessoryType.checkmark
            darkCell.accessoryType = UITableViewCellAccessoryType.none
        }
        /*if(globalRefresh)
        {
            Theme.setupUIColors()
            //Send notification
            NotificationCenter.default.post(name: .themeChanged, object: nil)
        }*/
        
        
    }
    
    func setAutoTheme( enabled: Bool)
    {
        if(enabled)
        {
            lightCellLabel.isEnabled = false
            darkCellLabel.isEnabled = false
            darkModeSlider.isEnabled = true
            autoTheme = true
        }else{
            lightCellLabel.isEnabled = true
            darkCellLabel.isEnabled = true
            darkModeSlider.isEnabled = false
            autoTheme = false
        }
    }
}


