import UIKit

extension UITableView {
    
    // MARK: - UITableViewCell
    
    func register<T: NSObject>(cellType: T.Type, bundle: Bundle? = nil) {
        let cellName = T.className
        let nib  = UINib(nibName: cellName, bundle: bundle)
        register(nib, forCellReuseIdentifier: cellName)
    }

    func dequeueReusableCell<T: UITableViewCell>(of type: T.Type, for indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as? T
    }
    
    // MARK: - UITableViewHeaderFooterView
    
    func register<T: NSObject>(headerFooterType: T.Type, bundle: Bundle? = nil) {
        let headerFooterName = T.className
        let nib  = UINib(nibName: headerFooterName, bundle: bundle)
        register(nib, forHeaderFooterViewReuseIdentifier: headerFooterName)
    }
    
    func dequeueHeaderFooterView<T: UITableViewHeaderFooterView>(of type: T.Type) -> T? {
        return self.dequeueReusableHeaderFooterView(withIdentifier: type.className) as? T
    }
    
    // MARK: - Sections & Cell classes
    
    func registerCellClasses<T: CaseIterable & RawRepresentable>(for sectionType: T.Type,
                                                                 using resolver: (T) -> UITableViewCell.Type) where T.RawValue == String {
        for section in sectionType.allCases {
            register(resolver(section), forCellReuseIdentifier: section.rawValue)
        }
    }
}
