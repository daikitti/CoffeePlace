//
//  AppDelegate.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 31.10.2024.
//

import UIKit
import YandexMapsMobile

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GpsManager.shared.requestCurrentLocation()
        YMKMapKit.setApiKey("862ca0a6-078b-42c5-b8e8-dc4d66e1806c")
        YMKMapKit.sharedInstance()

        let vc = cheakAuth()
        let navController = UINavigationController(rootViewController: vc)
        navController.isNavigationBarHidden = true
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }
  
}

extension AppDelegate{
    func cheakAuth() -> UIViewController{
        if CheckAuthentication.shared.getToken() != nil{
            return CoffePointAssembly().makeCoffePointViewController()
        }else{
            return LoadingAssembly().makeLoadingView()
        }
    }
}

