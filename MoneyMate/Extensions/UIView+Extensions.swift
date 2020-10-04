import UIKit

extension UIView {
    
    func roundCorners(radius: CGFloat = 5.0) {
        clipsToBounds = true
        layer.cornerRadius = radius
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat, bounds: CGRect? = nil) {
        let maskPath1 = UIBezierPath(roundedRect: bounds ?? self.bounds,
                                     byRoundingCorners: corners,
                                     cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds ?? self.bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    
    func takeScreenshot() -> UIImage {
        
        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        
        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if image != nil {
            return image!
        }
        return UIImage()
    }
    
    func removeSublayers() {
        layer.sublayers?.forEach { $0.removeFromSuperlayer() }
    }
    
    func setSideInsets(top: CGFloat = 0, left: CGFloat = 16, bottom: CGFloat = 0, right: CGFloat = 16) {
        let sideInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        frame = frame.inset(by: sideInsets)
    }
}
