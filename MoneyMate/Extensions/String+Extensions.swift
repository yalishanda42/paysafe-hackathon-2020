import UIKit

extension String {
    var hexColor: UIColor {
        let hex = trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let aaaa, rrrr, gggg, bbbb: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (aaaa, rrrr, gggg, bbbb) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (aaaa, rrrr, gggg, bbbb) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (aaaa, rrrr, gggg, bbbb) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return .clear
        }
        return UIColor(red: CGFloat(rrrr) / 255,
                       green: CGFloat(gggg) / 255,
                       blue: CGFloat(bbbb) / 255,
                       alpha: CGFloat(aaaa) / 255)
    }

    // Helper method to convert a DATE String to another desired date format for the UI.
    // If the date is in the incorrect format and the conversion fails an empty String is returned.
    func formattedDateString(existingDateFormat: String, desiredDateFormat: String) -> String {
        var convertedDateString: String  = ""

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = existingDateFormat

        if let convertedDate = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = desiredDateFormat
            convertedDateString = dateFormatter.string(from: convertedDate)
        }

        return convertedDateString
    }

    // Helper method to render an attributedString for desiredLineHeight and textAlignment
    func getAttributedStringFor(desiredLineHeight: CGFloat, textAlignment: NSTextAlignment) -> NSMutableAttributedString {
        let attributedString    = NSMutableAttributedString(string: self)
        let style               = NSMutableParagraphStyle()
        style.minimumLineHeight = desiredLineHeight
        style.alignment         = textAlignment

        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: self.count))

        return attributedString
    }
    
    // Helper method to render an attributedString for desiredLineHeight, textAlignment, font
    func getAttributedStringForFont(desiredLineHeight: CGFloat, textAlignment: NSTextAlignment, font: UIFont, range: NSRange) -> NSMutableAttributedString {
        let attributedString    = NSMutableAttributedString(string: self)
        let style               = NSMutableParagraphStyle()
        style.minimumLineHeight = desiredLineHeight
        style.alignment         = textAlignment
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: self.count))
        attributedString.addAttribute(.font, value: font, range: range)
        
        return attributedString
    }

    //Helper method to determine if a String is all numeric
    var isNumeric: Bool {
        guard !self.isEmpty else {
            return false
        }
        
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        
        return Set(self).isSubset(of: nums)
    }
}

///Helper method to access a localized string
extension String {
    
    /// Helper method for String manipulation
    subscript(_ range: NSRange) -> String {
        let start = self.index(self.startIndex, offsetBy: range.lowerBound)
        let end = self.index(self.startIndex, offsetBy: range.upperBound)
        let subString = self[start..<end]
        return String(subString)
    }
}

extension StringProtocol {
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
}

//removes unnecessary whitespace from strings 
extension String {
    func condenseWhitespace() -> String {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }

    func removeWhitespace() -> String {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: "")
    }

    func getComponent(forIndex: Int) -> String? {
        if self.isEmpty {
            return ""
        }
        let stringComponents = self.components(separatedBy: " ")
        return stringComponents[forIndex]
    }
}

extension String {
    var hexStringToBytes: [UInt8] {
        let hexa = Array(self)
        return stride(from: 0, to: count, by: 2).compactMap { UInt8(String(hexa[$0..<$0.advanced(by: 2)]), radix: 16) }
    }
}
