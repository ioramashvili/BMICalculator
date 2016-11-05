import UIKit

extension UILabel {
    @IBInspectable
    var adjustFontToRealIPhoneSize: Bool {
        set {
            if newValue {
                if let currentFont = font {
                    let realFontSize = Device.FontSizeScale.scale(fontSize: currentFont.pointSize)
                    font = currentFont.withSize(realFontSize)
                }
            }
        }
        get {
            return false
        }
    }
}

extension UIButton {
    @IBInspectable
    var adjustFontToRealIPhoneSize: Bool {
        set {
            if newValue {
                if let label = titleLabel, let currentFont = titleLabel?.font {
                    let realFontSize = Device.FontSizeScale.scale(fontSize: currentFont.pointSize)
                    label.font = currentFont.withSize(realFontSize)
                }
            }
        }
        get {
            return false
        }
    }
}

extension UITextField {
    @IBInspectable
    var adjustFontToRealIPhoneSize: Bool {
        set {
            if let currentFont = font {
                let realFontSize = Device.FontSizeScale.scale(fontSize: currentFont.pointSize)
                font = currentFont.withSize(realFontSize)
            }
        }
        get {
            return false
        }
    }
}

extension UITextView {
    @IBInspectable
    var adjustFontToRealIPhoneSize: Bool {
        set {
            if newValue {
                if let currentFont = font {
                    let realFontSize = Device.FontSizeScale.scale(fontSize: currentFont.pointSize)
                    font = currentFont.withSize(realFontSize)
                }
            }
        }
        
        get {
            return false
        }
    }
}






