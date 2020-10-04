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

        // Dashboard Tab
        let dashboardVC = DashboardViewController.instantiateFromStoryboard()
        dashboardVC.tabBarItem = UITabBarItem(title: "Dashboard", image: nil, tag: 1)
        dashboardVC.tabBarItem.selectedImage =  nil //UIImage(named: "home_active_icon")
        viewControllerList.append(dashboardVC)
        
        // Merket Tab
        let marketNavController = UINavigationController()
        marketNavController.tabBarItem = UITabBarItem(title: "Market", image: nil, tag: 2)
        marketNavController.tabBarItem.selectedImage = nil
        
        let marketVC = MarketViewController.instantiateFromStoryboard()
        marketNavController.pushViewController(marketVC, animated: false)
        viewControllerList.append(marketNavController)

        // Bank Tab
        let bankNavController = UINavigationController()
        bankNavController.tabBarItem = UITabBarItem(title: "Bank", image: resizeForTabBarImage("bank"), tag: 3)
        bankNavController.tabBarItem.selectedImage = resizeForTabBarImage("bank.fill")

        let bankVC = BankViewController.instantiateFromStoryboard()
        bankNavController.pushViewController(bankVC, animated: false)
        viewControllerList.append(bankNavController)
        
        viewControllers = viewControllerList
    }
    
    func resizeForTabBarImage(_ named: String) -> UIImage {
        let img = UIImage(named: named)!
        return img.resize(scaledToWidth: 24)
    }
}
