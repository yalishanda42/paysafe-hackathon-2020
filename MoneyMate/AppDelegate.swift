//
//  AppDelegate.swift
//  MoneyMate
//
//  Created by Luboslav  Ivanov on 3.10.20.
//  Copyright © 2020 Luboslav  Ivanov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupAppearance()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        Switcher.changeToIntroExperience()
//        let mainTabVc = MainTabViewController.instantiateFromStoryboard()
//        window?.rootViewController = mainTabVc
        return true
    }
}

extension AppDelegate {
    func setupAppearance() {
        UITabBar.appearance().tintColor = UIColor.fromAsset(.shamrockGreen)
        UITabBar.appearance().backgroundColor = UIColor.fromAsset(.khaki)
//        UITabBar.appearance().backgroundImage = UIImage()
//        UITabBar.appearance().shadowImage     = UIImage()
//        UITabBar.appearance().clipsToBounds   = true
        UINavigationBar.appearance().backgroundColor = .fromAsset(.pineGreen)
    }
}
