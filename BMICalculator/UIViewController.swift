import UIKit

extension UIViewController {
    static var name: String {
        return String(describing: self)
    }
    
    static var navigationName: String {
        return name + "NavigationController"
    }
}
