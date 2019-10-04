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

class SettingsViewController: UITableViewController {
    public var sessionService: SessionService?
    public var authenticationUIService: AuthenticationUIService?

    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var safariReaderModeSwitch: UISwitch!
    @IBOutlet weak var iconLabel: UILabel!

    private var usernameNotificaiton: NotificationToken?
    private var iconNotification: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTheming()
        updateIcon()
        safariReaderModeSwitch.isOn = UserDefaults.standard.safariReaderModeEnabled
        updateUsername()
        usernameNotificaiton = NotificationCenter.default
            .observe(name: AuthenticationUIService.Notifications.AuthenticationDidChangeNotification,
                     object: nil, queue: .main) { _ in self.updateUsername() }
        iconNotification = NotificationCenter.default
                  .observe(name: IconViewController.Notifications.IconDidChangeNotification,
                           object: nil, queue: .main) { _ in self.updateIcon() }
    }

    private func updateUsername() {
        if sessionService?.authenticationState == .authenticated {
            usernameLabel.text = sessionService?.username
        } else {
            usernameLabel.text = "Not logged in"
        }
    }

    private func updateTheme() {
        let settingsStore = SettingsStore()
        let theme = settingsStore.theme
        switch theme {
        case (.darkClassic):
            themeLabel.text = "Dark Classic"
        case (.lightClassic):
            themeLabel.text = "Light Classic"
        case (.dark):
            themeLabel.text = "Dark"
        case (.light):
            themeLabel.text = "Light"
        default:
            themeLabel.text = "Light"
        }
    }

    private func updateIcon() {
        if UIApplication.shared.alternateIconName != nil {
            iconLabel.text = "Classic"
        } else {
            iconLabel.text = "Hackers"
        }
    }

    @IBAction func safariReaderModelValueChanged(_ sender: UISwitch) {
        UserDefaults.standard.setSafariReaderMode(sender.isOn)
    }

    @IBAction private func didPressDone(_ sender: Any) {
        dismiss(animated: true)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        // override with empty implementation to prevent the extension running which reloads tableview data
    }
}

extension SettingsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            // login
            authenticationUIService?.showAuthentication()
        /*case (1, 1):
            if UIApplication.shared.supportsAlternateIcons {
                if let alternateIconName = UIApplication.shared.alternateIconName {
                    print("current icon is \(alternateIconName), change to primary icon")
                    UIApplication.shared.setAlternateIconName(nil)
                } else {
                    print("current icon is primary icon, change to alternative icon")
                    UIApplication.shared.setAlternateIconName("ClassicIcon"){ error in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            print("Done!")
                        }
                    }
                }
            }*/
        case (3, 0):
            // what's new
            if let viewController = OnboardingService.onboardingViewController(forceShow: true) {
                present(viewController, animated: true)
            }
        default: break
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension SettingsViewController: Themed {
    func applyTheme(_ theme: AppTheme) {
        updateTheme()
        if navigationController != nil {
            navigationController!.navigationBar.tintColor = theme.navBarTintColor
        }
        view.backgroundColor = theme.groupedTableViewBackgroundColor
    }
}
