import UIKit

enum ImageAsset: String {
    case rouming = "airplane"
    case autoFill = "auto_fill"
    case call = "balance-section-call"
    case intetnet = "internet"
    case sms = "mail"
    case menu = "menu"
    case message = "message"
    case meti = "meti"
    case credit = "percent"
    case search = "search"
    case servces = "services"
    case otherNumbers = "sim"
    case tariff = "tariff"
    case up = "up"
    case inside = "inside"
    
    
    case menuAbout = "about"
    case menuBalance = "balance"
    case menuHelp = "help"
    case menuNews = "news"
    case menuRegions = "regions"
    case menuSettings = "settings"
    
    case back = "back"
    
    case geocellTextualLogo = "geocell-textual-logo"
    
    case networkNotFound = "network-not-found"
}

extension ImageAsset {
    var image : UIImage {
        return UIImage(named: self.rawValue)!
    }
}

extension UIImage {
    convenience init(asset: ImageAsset) {
        self.init(named: asset.rawValue)!
    }
    
    static func image(withColor color: UIColor, inRect rect: CGRect) -> UIImage {
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
