//
//  AppDelegate.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 31.10.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let vc = LoadingAssembly().makeLoadingView()
        window?.rootViewController = UINavigationController(rootViewController:vc)
        window?.makeKeyAndVisible()
        return true
    }
  
}

