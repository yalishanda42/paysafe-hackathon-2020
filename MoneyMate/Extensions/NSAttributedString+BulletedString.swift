import UIKit
import Foundation

typealias ParagraphData = (bullet: String, paragraph: String)

extension NSAttributedString {
    
    static func makeBulletedAttributedString(paragraphDataPairs: [ParagraphData], attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
        let fullAttributedString = NSMutableAttributedString()
        
        paragraphDataPairs.forEach { paragraphData in
            let attributedString = makeBulletString(bullet: paragraphData.bullet,
                                                    content: paragraphData.paragraph,
                                                    attributes: attributes)
            fullAttributedString.append(attributedString)
        }
        
        return fullAttributedString
    }
    
    private static func makeBulletString(bullet: String, content: String,
                                         attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
        
        let formattedString: String = "\(bullet)\(content)\n"
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: formattedString,
                                                                                    attributes: attributes)
        
        let headerIndent = (bullet as NSString).size(withAttributes: attributes).width
        attributedString.addAttributes([.paragraphStyle: makeParagraphStyle(headIndent: headerIndent)],
                                       range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }
    
   private static func makeParagraphStyle(headIndent: CGFloat) -> NSParagraphStyle {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = headIndent
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.paragraphSpacing = 5
        paragraphStyle.lineSpacing = 2

        return paragraphStyle
    }
}
