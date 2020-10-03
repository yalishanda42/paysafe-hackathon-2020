//
//  MainTabViewController.swift
//  MoneyMate
//
//  Created by Luboslav  Ivanov on 3.10.20.
//  Copyright © 2020 Luboslav  Ivanov. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
}

private extension MainTabViewController {
    func setupViewControllers() {
        var viewControllerList: [UIViewController] = []

        let dashboardVC = DashboardViewController.instantiateFromStoryboard()
        dashboardVC.tabBarItem = UITabBarItem(title: "Dashboard", image: nil, tag: 1)
        dashboardVC.tabBarItem.selectedImage =  nil //UIImage(named: "home_active_icon")
        viewControllerList.append(dashboardVC)

        let marketVC = MarketViewController.instantiateFromStoryboard()
        marketVC.tabBarItem = UITabBarItem(title: "Market", image: nil, tag: 2)
        marketVC.tabBarItem.selectedImage = nil //UIImage(named: "resourcesActive")
        viewControllerList.append(marketVC)

        let navController = UINavigationController()
        navController.tabBarItem = UITabBarItem(title: "Bank", image: nil, tag: 3)
        navController.tabBarItem.selectedImage = nil //UIImage(named: "settingsActive")

        let bankVC = BankViewController.instantiateFromStoryboard()
        navController.pushViewController(bankVC, animated: true)

        viewControllerList.append(navController)
        viewControllers = viewControllerList
    }
}
