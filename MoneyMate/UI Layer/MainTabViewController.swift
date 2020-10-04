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
        dashboardVC.tabBarItem = UITabBarItem(title: "Dashboard", image: resizeForTabBarImage("house"), tag: 1)
        dashboardVC.tabBarItem.selectedImage =  resizeForTabBarImage("house.fill")
        viewControllerList.append(dashboardVC)

        let marketVC = MarketViewController.instantiateFromStoryboard()
        marketVC.tabBarItem = UITabBarItem(title: "Market", image: resizeForTabBarImage("cart"), tag: 2)
        marketVC.tabBarItem.selectedImage = resizeForTabBarImage("cart.fill")
        viewControllerList.append(marketVC)

        let navController = UINavigationController()
        navController.tabBarItem = UITabBarItem(title: "Bank", image: resizeForTabBarImage("bank"), tag: 3)
        navController.tabBarItem.selectedImage = resizeForTabBarImage("bank.fill")

        let bankVC = BankViewController.instantiateFromStoryboard()
        navController.pushViewController(bankVC, animated: true)

        viewControllerList.append(navController)
        viewControllers = viewControllerList
    }
    
    func resizeForTabBarImage(_ named: String) -> UIImage? {
        let img = UIImage(named: named) ?? UIImage(systemName: named)
        return img?.resize(scaledToWidth: 24)
    }
}
