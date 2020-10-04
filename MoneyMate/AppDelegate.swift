//
//  AppDelegate.swift
//  MoneyMate
//
//  Created by Luboslav  Ivanov on 3.10.20.
//  Copyright © 2020 Luboslav  Ivanov. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            // Enable or disable features based on authorization.
            if error != nil {
                print("Request authorization failed!")
            } else {
                print("Request authorization succeeded!")
            }
        }

        setupAppearance()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        Switcher.changeToIntroExperience()
//        let mainTabVc = MainTabViewController.instantiateFromStoryboard()
//        window?.rootViewController = mainTabVc
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("poluchih 1")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("poluchih 2")
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

