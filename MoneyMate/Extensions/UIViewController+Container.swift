import UIKit
import Foundation

extension UIViewController {
    
    // MARK: - Child Controllers Helpers
    
    func add(asChildViewController viewController: UIViewController, containerView: UIView? = nil) {
        
        let view: UIView = containerView ?? self.view
        
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        view.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.wrapInsideParent()
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    func remove() {
        // Just to be safe, check that this view controller is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }
        
        // Notify Child View Controller
        willMove(toParent: nil)
        
        // Remove Child View From Superview
        view.removeFromSuperview()
        
        // Notify Child View Controller
        removeFromParent()
    }
    
    func remove(asChildViewController viewController: UIViewController) {
        viewController.remove()
    }
}
