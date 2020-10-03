import UIKit

extension UIView {

    func roundCorners(radius: CGFloat = 5.0) {
        clipsToBounds = true
        layer.cornerRadius = radius
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
}
