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

class IconViewController: UITableViewController {

    @IBOutlet weak var hackersCell: UITableViewCell!
    @IBOutlet weak var classicCell: UITableViewCell!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateIcon()
    }

    private func updateIcon() {
        let currentCell: UITableViewCell?
        if UIApplication.shared.alternateIconName != nil {
            currentCell = classicCell
            hackersCell.accessoryType = .none
            classicCell.accessoryType = .checkmark
        } else {
            hackersCell.accessoryType = .checkmark
            currentCell = hackersCell
            classicCell.accessoryType = .none
        }
        updateIconAccessory(cell: currentCell)
    }

    private func updateIconAccessory(cell: UITableViewCell?) {
        let theme = AppThemeProvider.shared.currentTheme
        cell?.tintColor = theme.appTintColor
    }

    @IBAction private func didPressDone(_ sender: Any) {
        dismiss(animated: true)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        // override with empty implementation to prevent the extension running which reloads tableview data
    }

    enum Notifications {
        static let IconDidChangeNotification =
            NSNotification.Name(rawValue: "IconDidChangeNotification")
    }
}

extension IconViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let iconName: String?
        let currentCell: UITableViewCell?
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            // hackers
            hackersCell.accessoryType = .checkmark
            currentCell = hackersCell
            classicCell.accessoryType = .none
            iconName = nil
        case (0, 1):
            // classic
            hackersCell.accessoryType = .none
            classicCell.accessoryType = .checkmark
            currentCell = classicCell
            iconName = "ClassicIcon"
        default:
            hackersCell.accessoryType = .checkmark
            currentCell = hackersCell
            classicCell.accessoryType = .none
            iconName = nil
        }
        if UIApplication.shared.supportsAlternateIcons {
            updateIconAccessory(cell: currentCell)
            UIApplication.shared.setAlternateIconName(iconName)
            sendIconDidChangeNotification()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        //need parent cell to repaint the icon
    }
    
    private func sendIconDidChangeNotification() {
        NotificationCenter.default.post(name: Notifications.IconDidChangeNotification, object: nil)
    }
}

extension IconViewController: Themed {
    func applyTheme(_ theme: AppTheme) {
        view.backgroundColor = theme.groupedTableViewBackgroundColor
    }
}
