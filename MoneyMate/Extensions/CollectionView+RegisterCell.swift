import UIKit

extension UICollectionView {
    
    func register<T: NSObject>(cellType: T.Type, bundle: Bundle? = nil) {
        let cellName = T.className
        let nib = UINib(nibName: cellName, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: cellName)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(of type: T.Type, for indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as? T
    }
}
