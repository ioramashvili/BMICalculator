import UIKit

@IBDesignable
class ProgressView: UIView {
    
    let mainCircle = CAShapeLayer()
    let backgroundCircle = CAShapeLayer()
    
    @IBInspectable var lineWidth: CGFloat = 4 {
        didSet {
            mainCircle.lineWidth = lineWidth
        }
    }
    
    @IBInspectable var fillColor: UIColor = UIColor.clear {
        didSet {
            mainCircle.fillColor = fillColor.cgColor
        }
    }
    
    @IBInspectable var strokeColor: UIColor = UIColor.white {
        didSet {
            mainCircle.strokeColor = strokeColor.cgColor
        }
    }
    
    @IBInspectable var strokeStart: CGFloat = 0 {
        didSet {
            mainCircle.strokeStart = strokeStart
        }
    }
    
    @IBInspectable var strokeEnd: CGFloat = 1 {
        didSet {
            mainCircle.strokeEnd = strokeEnd
        }
    }
    
    @IBInspectable var strokeEndBackground: UIColor = UIColor.clear {
        didSet {
            backgroundCircle.strokeColor = strokeEndBackground.cgColor
        }
    }
    
    override func draw(_ rect: CGRect) {
        let radius: CGFloat = min(bounds.width, bounds.height) / 2 - lineWidth / 2
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let startAngle = CGFloat(3 * M_PI_2)
        let endAngle = CGFloat(2 * M_PI) + startAngle
        
        
        mainCircle.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true).reversing().cgPath
        mainCircle.fillColor = fillColor.cgColor
        mainCircle.strokeColor = strokeColor.cgColor
        mainCircle.lineWidth = lineWidth
        mainCircle.lineCap = kCALineCapRound
        mainCircle.strokeStart = strokeStart
        mainCircle.strokeEnd = strokeEnd
        
        backgroundCircle.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true).reversing().cgPath
        
        // Configure the circle
        backgroundCircle.fillColor = fillColor.cgColor
        backgroundCircle.strokeColor = strokeEndBackground.cgColor
        backgroundCircle.lineWidth = lineWidth
        backgroundCircle.lineCap = kCALineCapRound
        backgroundCircle.strokeStart = 0
        backgroundCircle.strokeEnd = 1
        
        layer.addSublayer(backgroundCircle)
        layer.addSublayer(mainCircle)
    }
}


