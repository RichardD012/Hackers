//
//  SettingsStore.swift
//  Hackers
//
//  Created by Weiran Zhang on 22/06/2019.
//  Copyright © 2019 Glass Umbrella. All rights reserved.
//

import SwiftUI
import Combine
import UIKit
import HNScraper

class SettingsStore: ObservableObject {
    var didChange = PassthroughSubject<Void, Never>()

    private enum Keys {
        static let theme = "theme"
        static let safariReaderMode = "safariReaderMode"
        static let username = "username"
        static let posts = "posts"
    }
    private static var hasLoaded = false
    private static var postDictionary: [String: Date] = [String: Date]() //faster than getting from storage constantly
    private let cancellable: Cancellable
    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults

        defaults.register(defaults: [
            Keys.theme: ThemeType.system.rawValue,
            Keys.safariReaderMode: false,
            Keys.posts: [String: Date]()
        ])
        cancellable = NotificationCenter.default
            .publisher(for: UserDefaults.didChangeNotification)
            .map { _ in () }
            .subscribe(didChange)
        self.initializePosts()
    }

    func initializePosts() {
        if SettingsStore.hasLoaded == false {
            //load it
            SettingsStore.hasLoaded = true
            guard let storedDictionary = UserDefaults.standard.value(forKey: Keys.posts) as? [String: Date] else {
                SettingsStore.postDictionary = [String: Date]()
                return
            }
            SettingsStore.postDictionary = storedDictionary
            let cutoff = Date().addingTimeInterval((-60*60*24*30)) //30 days
            var updates = false
            for (postId, date) in SettingsStore.postDictionary where date < cutoff {
                updates = true
                SettingsStore.postDictionary.removeValue(forKey: postId)
            }
            if updates {
                defaults.set(SettingsStore.postDictionary, forKey: Keys.posts)
                defaults.synchronize()
            }
        }
    }

    enum ThemeType: String, CaseIterable {
        case system
        case dark
        case light
        case darkClassic
        case lightClassic
    }

    var theme: ThemeType {
        set {
            defaults.set(newValue.rawValue, forKey: Keys.theme)
            ThemeSwitcher.switchTheme()
        }
        get { return defaults.string(forKey: Keys.theme)
            .flatMap { ThemeType(rawValue: $0) } ?? .system
        }
    }

    var safariReaderMode: Bool {
        set { defaults.set(newValue, forKey: Keys.safariReaderMode) }
        get { return defaults.bool(forKey: Keys.safariReaderMode) }
    }

    var username: String? {
        set { defaults.set(newValue, forKey: Keys.username) }
        get { return defaults.string(forKey: Keys.username) }
    }

    func visited(post: HNPost) -> Bool {
        initializePosts()
        return SettingsStore.postDictionary[post.id] != nil
    }

    func setVisited(post: HNPost) {
        initializePosts()
        let date = Date()
        SettingsStore.postDictionary[post.id] = date
        defaults.set(SettingsStore.postDictionary, forKey: Keys.posts)
        defaults.synchronize()
    }
}
