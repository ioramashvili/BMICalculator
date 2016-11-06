import UIKit

extension UINavigationBar {
    func setShadowImage(withColor color: UIColor) {
        shadowImage = UIImage.image(
            withColor: color,
            inRect: CGRect(x: 0, y: 0, width: 1, height: 0.5))
    }
    
    
    func setBackgroundImage(withColor color: UIColor) {
        let image = UIImage.image(
            withColor: color,
            inRect: CGRect(x: 0, y: 0, width: frame.width, height: 64))
        setBackgroundImage(image, for: UIBarMetrics.default)
    }
    
    func defaultBar(withShadowColor color: UIColor = UIColor.white.withAlphaComponent(0.4)) {
        barTintColor = ProjectColor.navigationBarTitleColor.color
        tintColor = ProjectColor.geocell.color
        titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: ProjectFont.base.rawValue, size: 16)!
        ]
        isTranslucent = true
        
        setShadowImage(withColor: color)
        setBackgroundImage(withColor: UIColor.clear)
    }
}
