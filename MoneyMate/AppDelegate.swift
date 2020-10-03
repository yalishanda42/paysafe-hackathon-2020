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
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let mainTabVc = MainTabViewController.instantiateFromStoryboard()
        window?.rootViewController = mainTabVc
        return true
    }
}
