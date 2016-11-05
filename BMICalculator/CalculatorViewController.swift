import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var controlerWrapperView: UIView!
    
    @IBOutlet weak var ageScrollView: UIScrollView!
    @IBOutlet weak var heightScrollView: UIScrollView!
    @IBOutlet weak var weightScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.defaultBar()
        navigationBar.isTranslucent = true
        navigationBar.setBackgroundImage(withColor: UIColor.clear)
        navigationBar.shadowImage = UIImage.image(
            withColor: UIColor.white.withAlphaComponent(0.4),
            inRect: CGRect(x: 0, y: 0, width: 1, height: 0.5))
        navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: ProjectFont.base.rawValue, size: 16)!
        ]
        
        setupScrollView(scrollView: ageScrollView)
        setupScrollView(scrollView: heightScrollView)
        setupScrollView(scrollView: weightScrollView)
        
        createGradinet()
    }
    
    func createGradinet() {
        let colorTop =  UIColor(named: "3CAA7BFF").cgColor
        let colorBottom = UIColor(named: "4ED076FF").cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        gradientLayer.locations = [0.0, 0.5]
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setupScrollView(scrollView: UIScrollView) {
        scrollView.delegate = self
        scrollView.decelerationRate = UIScrollViewDecelerationRateFast
        
        let labelSize: CGFloat = 50
        let labelCount = 40
        for index in 0..<labelCount {
            let label = UILabel(frame: CGRect(x: CGFloat(index) * labelSize, y: 0, width: labelSize, height: labelSize))
            label.textAlignment = .center
            label.font = ProjectFont.base.with(size: 18)
            label.text = "\(index + 1)"
            label.textColor = UIColor(named: "ABABABFF")
            scrollView.addSubview(label)
        }
        
        scrollView.contentSize = CGSize(width: CGFloat(labelCount) * labelSize, height: labelSize)
        
        scrollView.contentInset.left = (UIScreen.main.bounds.width - labelSize) / 2
        scrollView.contentInset.right = (UIScreen.main.bounds.width - labelSize) / 2
        scrollView.contentOffset.x = -scrollView.contentInset.left

    }
    
    func setupScrollViewBorders(scrollView: UIScrollView) {
        let color = UIColor(named: "879990FF").withAlphaComponent(0.3)
        _ = scrollView.superview!.layer.addBorder(edge: .top, color: color, thickness: 0.5)
        _ = scrollView.superview!.layer.addBorder(edge: .bottom, color: color, thickness: 0.5)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupScrollViewBorders(scrollView: ageScrollView)
        setupScrollViewBorders(scrollView: heightScrollView)
        setupScrollViewBorders(scrollView: weightScrollView)
        
        controlerWrapperView.layer.shadowOpacity = 1
        controlerWrapperView.layer.shadowRadius = 8
        controlerWrapperView.layer.shadowColor = UIColor.white.cgColor
        controlerWrapperView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}


extension CalculatorViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.x + scrollView.contentInset.left)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print("scrollViewWillEndDragging ", targetContentOffset.pointee.x)
        let normalize = max(0, targetContentOffset.pointee.x + scrollView.contentInset.left) + 25
        let index = Int(normalize / 50)
        targetContentOffset.pointee.x = CGFloat(index) * 50 - scrollView.contentInset.left
        print("scrollViewWillEndDragging ", normalize, index, targetContentOffset.pointee.x)
    }
}




















