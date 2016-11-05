import UIKit

// ფერის კლასის გაფართოება ინიციალიზატორებით
extension UIColor {
    // ფერის ობიექტის შექმნა ენამის ქეისით
    convenience init(named name: ProjectColor) {
        self.init(named: name.rawValue)
    }
    
    // ფერის ობიექტის შექმნა სტრიქონიდან
    convenience init(named name: String) {
        let rgba = name.toUInt32.toRGBA
        self.init(red: rgba.red, green: rgba.green, blue: rgba.blue, alpha: rgba.alpha)
    }
}

extension ProjectColor {
    var color : UIColor {
        return UIColor(named: self)
    }
}

extension String {
    var toUInt32 : UInt32 { return UInt32(self, radix: 16)! }
}

extension UInt32 {
    var toRGBA : (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        get {
            let red   = CGFloat((self >> 24) & 0xff) / 255.0
            let green = CGFloat((self >> 16) & 0xff) / 255.0
            let blue  = CGFloat((self >>  8) & 0xff) / 255.0
            let alpha = CGFloat((self      ) & 0xff) / 255.0
            
            return (red, green, blue, alpha)
        }
    }
}

// გამოყენების მაგალით

// let color1 = UIColor(named: ProjectColor.NavigationBar)
// let color2 = ProjectColor.NavigationBar.color
