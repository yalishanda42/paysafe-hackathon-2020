import UIKit
import Foundation

extension UIViewController {
    
    func presentAlert(title: String?, message: String?,
                      actionOneTitle: String?,
                      actionOneStyle: UIAlertAction.Style = .default,
                      actionOneHandler: ((UIAlertAction) -> Void)? = nil,
                      actionTwoTitle: String? = nil,
                      actionTwoStyle: UIAlertAction.Style = .default,
                      actionTwoHandler: ((UIAlertAction) -> Void)? = nil ) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let title = actionOneTitle {
            let actionOne = UIAlertAction(title: title, style: actionOneStyle, handler: actionOneHandler)
            alertController.addAction(actionOne)
        }
        
        if let title = actionTwoTitle {
            let actionTwo = UIAlertAction(title: title, style: actionTwoStyle, handler: actionTwoHandler)
            alertController.addAction(actionTwo)
        }

        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }

    func presentOkButtonAlert(title: String?, message: String?, actionHandler: ((UIAlertAction) -> Void)? = nil) {
        presentAlert(title: title,
                     message: message,
                     actionOneTitle: "OK",
                     actionOneHandler: actionHandler)
    }
}
