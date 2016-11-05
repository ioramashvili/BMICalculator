import UIKit

@IBDesignable
class DirectionView: UIView {
    let shapeLayer = CAShapeLayer()
    
    @IBInspectable var strokeColor: UIColor = UIColor.white {
        didSet {
            shapeLayer.strokeColor = strokeColor.cgColor
        }
    }
    
    @IBInspectable var shapeLineWidth: CGFloat = 4 {
        didSet {
            
        }
    }
    
    @IBInspectable var isLeftDirection: Bool = true {
        didSet {
            
        }
    }
    
    override func draw(_ rect: CGRect) {
        let margin = ceil(shapeLineWidth / 2)
        
        let middlePointX = isLeftDirection ? margin : bounds.width - margin
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.width / 2, y: margin))
        path.addLine(to: CGPoint(x: middlePointX, y: bounds.height / 2))
        path.addLine(to: CGPoint(x: bounds.width / 2, y: bounds.height - margin))
        
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = shapeLineWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        layer.addSublayer(shapeLayer)
    }
}
