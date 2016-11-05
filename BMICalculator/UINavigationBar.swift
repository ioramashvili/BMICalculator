import UIKit

extension UINavigationBar {
    func setShadowImage(withColor color: UIColor) {
        shadowImage = UIImage.image(
            withColor: color,
            inRect: CGRect(x: 0, y: 0, width: 1, height: 1))
    }
    
    
    func setBackgroundImage(withColor color: UIColor) {
        let image = UIImage.image(
            withColor: color,
            inRect: CGRect(x: 0, y: 0, width: frame.width, height: 64))
        setBackgroundImage(image, for: UIBarMetrics.default)
    }
    
    func defaultBar(withShadowColor color: UIColor = ProjectColor.navigationBarShadowColor.color) {
        barTintColor = ProjectColor.navigationBarTitleColor.color
        tintColor = ProjectColor.geocell.color
        titleTextAttributes = [
            NSForegroundColorAttributeName: ProjectColor.navigationBarTitleColor.color,
            NSFontAttributeName: UIFont(name: ProjectFont.base.rawValue, size: 15)!
        ]
        isTranslucent = false
        
        setShadowImage(withColor: color)
        setBackgroundImage(withColor: UIColor.white)
    }
}
