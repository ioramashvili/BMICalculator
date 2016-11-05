import Foundation
import UIKit

extension String {
    func frameSize(font: UIFont, constant: CGFloat, lineHeight: CGFloat = 1) -> CGRect {
        
        let paragraphStyle = NSMutableParagraphStyle()
        //        paragraphStyle.lineSpacing = 1.0
        paragraphStyle.lineHeightMultiple = lineHeight
        //        paragraphStyle.alignment = self.textAlignment
        
        let attrString = NSMutableAttributedString(string: self)
        attrString.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, attrString.length))
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        let screenWidth = UIScreen.main.bounds.width
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth - constant, height: 0))
        label.attributedText = attrString
        label.numberOfLines = 0
        label.sizeToFit()
        return label.frame
    }
    
    func frameSize(font: UIFont, insets: UIEdgeInsets) -> CGRect {
        let button = UIButton()
        button.setTitle(self, for: .normal)
        button.titleLabel?.font = font
        button.contentEdgeInsets = insets
        button.sizeToFit()
        return button.frame
    }
}
