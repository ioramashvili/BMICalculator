import UIKit

@IBDesignable
class OKView: UIView {
    
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
    
    override func draw(_ rect: CGRect) {
        let margin = ceil(shapeLineWidth / 2)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: margin, y: bounds.height * 0.7))
        path.addLine(to: CGPoint(x: bounds.width * 0.3, y: bounds.height - margin))
        path.addLine(to: CGPoint(x: bounds.width - margin, y: bounds.height * 0.2))
        
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = shapeLineWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        layer.addSublayer(shapeLayer)
    }
}
