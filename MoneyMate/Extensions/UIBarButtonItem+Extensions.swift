import UIKit
import Foundation

extension UIBarButtonItem {
    /// Helper method to set attribtes for all UIBarButtonItem states
    func setTitleTextAttributesAllStates(font: UIFont, color: UIColor) {
        setTitleTextAttributes([
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color
            ], for: .normal)

        setTitleTextAttributes([
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color
            ], for: .highlighted)

        setTitleTextAttributes([
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color
            ], for: .selected)
    }

    // Helper method that moves the UIUBarButtonItem's image offset to the left
    func adjustFrameOffsetLeft(leftOffset: CGFloat) {
        var adjustedInsets: UIEdgeInsets = self.imageInsets
        adjustedInsets.left -= leftOffset
        self.imageInsets = adjustedInsets
    }
}
