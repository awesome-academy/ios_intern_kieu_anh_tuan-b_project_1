//
//  AppDelegate.swift
//  MarvelApp
//
//  Created by Tobi on 11/09/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = AppTabBarController()
        window?.makeKeyAndVisible()

        return true
    }
}
