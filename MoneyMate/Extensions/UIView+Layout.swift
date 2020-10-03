import UIKit
import Foundation

extension UIView {
    
    func wrapInsideParent() {
        
        let views = ["view": self]
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                                 options: .alignAllCenterY,
                                                                 metrics: nil,
                                                                 views: views)
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                                   options: .alignAllCenterX,
                                                                   metrics: nil,
                                                                   views: views)
        addInParent(with: verticalConstraints + horizontalConstraints)
    }
    
    func addInParent(with constraints: [NSLayoutConstraint]) {
        guard let parentView = superview else {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        parentView.addConstraints(constraints)
    }

    func embed(_ view: UIView) {
        self.insertSubview(view, at: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                                    options: [],
                                                                    metrics: nil,
                                                                    views: ["view": view]))

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                                    options: [],
                                                                    metrics: nil,
                                                                    views: ["view": view]))
        self.layoutIfNeeded()
    }
}

extension UIView {

    enum OrientationFit {
        case horizontally
        case vertically
        case horizontallyAndVertically
    }

    /** Center the provided view in current view by adding necessary constraints, and adding the view as a subview, if needed.
     - parameter view: The subview to be added. Must have intrinsic size or height and width manually set.
     */
    func center(subView view: UIView,
                orientated orientation: OrientationFit = .horizontallyAndVertically) {

        center(subView: view, orientated: orientation, withOffset: CGPoint.zero)
    }

    /** Center the provided view in current view by adding necessary constraints, and adding the view as a subview, if needed.
     - parameter view: The subview to be added. Must have intrinsic size or height and width manually set.
     - parameter offset: The offset from the center to use.
     */
    func center(subView view: UIView,
                orientated orientation: OrientationFit = .horizontallyAndVertically,
                withOffset offset: CGPoint) {

        if view.superview != self {
            self.addSubview(view)
        }

        view.translatesAutoresizingMaskIntoConstraints = false

        if orientation == .horizontally || orientation == .horizontallyAndVertically {
            let constraint = NSLayoutConstraint(item: view,
                                                attribute: .centerX,
                                                relatedBy: .equal,
                                                toItem: view.superview!,
                                                attribute: .centerX,
                                                multiplier: 1.0,
                                                constant: offset.x)
            addConstraint(constraint)
        }

        if orientation == .vertically || orientation == .horizontallyAndVertically {
            let constraint = NSLayoutConstraint(item: view,
                                                attribute: .centerY,
                                                relatedBy: .equal,
                                                toItem: view.superview!,
                                                attribute: .centerY,
                                                multiplier: 1.0,
                                                constant: offset.y)
            addConstraint(constraint)
        }
    }

    func place(subView: UIView,
               under view: UIView,
               withOffset offset: CGPoint) {

        guard let subViewSuperview = subView.superview else { return }
        guard let viewSuper = view.superview else { return }
        guard subViewSuperview === viewSuper else { return }

        let constraint = NSLayoutConstraint(item: subView,
                                            attribute: .top,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .bottom,
                                            multiplier: 1.0,
                                            constant: offset.y)
        subViewSuperview.addConstraint(constraint)
    }

    func place(subView view: UIView, withOffsetFromTop yOffset: CGFloat) {

        if view.superview != self {
            self.addSubview(view)
        }

        view.translatesAutoresizingMaskIntoConstraints = false

        let constraint = NSLayoutConstraint(item: view,
                                            attribute: .top,
                                            relatedBy: .equal,
                                            toItem: view.superview!,
                                            attribute: .top,
                                            multiplier: 1.0,
                                            constant: yOffset)
        addConstraint(constraint)
    }
}
