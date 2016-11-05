import UIKit

extension UIScrollView {
    
    enum Direction {
        case down
        case up
        case left
        case right
        case none
    }
    
    var normalizedContentOffsetY: CGFloat {
        return contentOffset.y + contentInset.top
    }
    
    var normalizedContentOffsetX: CGFloat {
        return contentOffset.x + contentInset.left
    }
}
