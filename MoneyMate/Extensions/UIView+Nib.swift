import UIKit

extension UIView {

    static var nibName: String {
        let name = String(describing: self).components(separatedBy: ".").first ?? ""
        return name
    }

    class func fromNib<T: UIView>() -> T? {
        if let nibViews = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil) {
            return nibViews.first as? T
        }
        return nil
    }
}
