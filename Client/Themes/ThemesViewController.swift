//
//  SettingsViewController.swift
//  Hackers
//
//  Created by Weiran Zhang on 05/05/2018.
//  Copyright © 2018 Glass Umbrella. All rights reserved.
//

import UIKit
import PromiseKit
import HNScraper
import Loaf

class ThemesViewController: UITableViewController {
    public var sessionService: SessionService?
    public var authenticationUIService: AuthenticationUIService?

    @IBOutlet weak var lightCell: UITableViewCell!
    @IBOutlet weak var darkCell: UITableViewCell!
    @IBOutlet weak var lightClassicCell: UITableViewCell!
    @IBOutlet weak var darkClassicCell: UITableViewCell!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateTheme()
    }

    private func updateTheme() {
        let settingsStore = SettingsStore()
        let appTheme = AppThemeProvider.shared.currentTheme
        let theme = settingsStore.theme
        switch theme {
        case (.darkClassic):
            darkClassicCell.accessoryType = .checkmark
            darkClassicCell.tintColor = appTheme.appTintColor
            disableRows(cells: lightClassicCell, darkCell, lightCell)
        case (.lightClassic):
            lightClassicCell.accessoryType = .checkmark
            lightClassicCell.tintColor = appTheme.appTintColor
            disableRows(cells: darkClassicCell, darkCell, lightCell)
        case (.dark):
            darkCell.accessoryType = .checkmark
            darkCell.tintColor = appTheme.appTintColor
            disableRows(cells: lightClassicCell, darkClassicCell, lightCell)
        case (.light):
            lightCell.accessoryType = .checkmark
            lightCell.tintColor = appTheme.appTintColor
            disableRows(cells: lightClassicCell, darkClassicCell, darkCell)
        default:
            lightCell.accessoryType = .checkmark
            lightCell.tintColor = appTheme.appTintColor
            disableRows(cells: lightClassicCell, darkClassicCell, darkCell)
        }
    }

    private func disableRows(cells: UITableViewCell...) {
        for cell in cells {
            cell.accessoryType = .none
        }
    }

    @IBAction private func didPressDone(_ sender: Any) {
        dismiss(animated: true)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        // override with empty implementation to prevent the extension running which reloads tableview data
    }
}

extension ThemesViewController {
    /*
     UserDefaults.standard.setDarkMode(sender.isOn)
     //AppThemeProvider.shared.currentTheme = sender.isOn ? .dark : .light
     AppThemeProvider.shared.currentTheme = sender.isOn ? .darkClassic : .light
     */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let settingsStore = SettingsStore()
        var theme: SettingsStore.ThemeType
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            // light
            theme = .light
        case (0, 1):
            // dark
            theme = .dark
        case (0, 2):
           // light classic
            theme = .lightClassic
        case (0, 3):
            // dark classic
            theme = .darkClassic
        default:
            theme = .light
        }
        settingsStore.theme = theme
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            tableView.deselectRow(at: indexPath, animated: true)
            self.dismiss(animated: true)
        }
        //dismiss(animated: true) //send the selected cell to the parent
    }
}

extension ThemesViewController: Themed {
    func applyTheme(_ theme: AppTheme) {
        view.backgroundColor = theme.groupedTableViewBackgroundColor
        if navigationController != nil {
            navigationController!.navigationBar.tintColor = theme.navBarTintColor
        }
        lightCell.tintColor = theme.appTintColor
        darkCell.tintColor = theme.appTintColor
        lightClassicCell.tintColor = theme.appTintColor
        darkClassicCell.tintColor = theme.appTintColor
    }
}
