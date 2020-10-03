import UIKit
import Foundation

extension NSAttributedString {
    
    static func createTextWithLink(displayText: String, linkText: String, linkValue: String, attributes: [NSAttributedString.Key: Any]? = nil) -> NSAttributedString? {
        
        let attributedString = NSMutableAttributedString(string: displayText, attributes: attributes)
        let range = (displayText as NSString).range(of: displayText)
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .left
        
        attributedString.addAttribute(.paragraphStyle, value: paragraph, range: range)
        
        guard let linkRange = displayText.range(of: linkText) else {
            return nil
        }
        
        attributedString.addAttribute(.link, value: linkValue, range: NSRange(linkRange, in: displayText))
        return attributedString
    }
}
