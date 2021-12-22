//
//  AppDelegate.swift
//  HXHSwiftHub
//
//  Created by huangyu on 2021/7/26.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupUI()
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("url:\(url)")
        return true
    }
}

//MARK: - UI set extension
extension AppDelegate {
    func setupUI() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let rootVC = HXHBaseNavigationController(rootViewController: MainVC())
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
    }
}

