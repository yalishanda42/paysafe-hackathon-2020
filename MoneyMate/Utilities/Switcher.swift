import Foundation
import UIKit

class Switcher {

//    static func changeToIntroExperience() {
//        let introExperienceVC: IntroExperienceViewController = UIStoryboard(.introExperience).instantiateViewController()
//
//        let navigationVC = introExperienceVC.embedInNavigation()
//        navigationVC.modalPresentationStyle = .fullScreen
//
//        changeRootTo(navigationVC)
//    }

    /// This will load the tabbar as the rootViewController
    static func changeRootToTab() {
        DispatchQueue.main.async {
            let tabVC = MainTabViewController.instantiateFromStoryboard()

            changeRootTo(tabVC) { _ in
                print("Switched to Main Tab Bar")
            }
        }
    }
    
    private static func changeRootTo(_ viewController: UIViewController, modalPresentationStyle: UIModalPresentationStyle? = nil, completion: ((UIViewController) -> Void)? = nil) {
        var rootVC: UIViewController = viewController

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        guard let window = UIApplication.shared.keyWindow else {
            return
        }

        rootVC = viewController

        rootVC.view.alpha = 0.8
        if let modalPresentationStyle = modalPresentationStyle {
            rootVC.modalPresentationStyle = modalPresentationStyle
        }

        appDelegate.window?.rootViewController = rootVC

        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            rootVC.view.alpha = 1.0
        }, completion: { _ in
            rootVC.view.setNeedsUpdateConstraints()
            completion?(rootVC)
        })
    }
}
