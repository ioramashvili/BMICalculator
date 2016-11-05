import UIKit

extension UIView {
    func makeCornerRadiusHalfOfHeight() {
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    func makeCornerRadiusHalfOfWidth() {
        self.layer.cornerRadius = self.frame.width / 2
    }
}
