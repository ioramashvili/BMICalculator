import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var controlerWrapperView: UIView!
    
    @IBOutlet weak var ageScrollView: UIScrollView!
    @IBOutlet weak var heightScrollView: UIScrollView!
    @IBOutlet weak var weightScrollView: UIScrollView!
    
    var model: Model!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.defaultBar()
        
        let item1 = Item(section: .age, dimention: .male, scrollView: ageScrollView, titleLabel: UILabel())
        let item2 = Item(section: .height, dimention: .cm, scrollView: heightScrollView, titleLabel: UILabel())
        let item3 = Item(section: .weight, dimention: .kg, scrollView: weightScrollView, titleLabel: UILabel())
        
        model = Model(items: [item1, item2, item3], delegate: self)
        
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
//        print(scrollView.contentOffset.x + scrollView.contentInset.left)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print("scrollViewWillEndDragging ", targetContentOffset.pointee.x)
        let normalize = max(0, targetContentOffset.pointee.x + scrollView.contentInset.left) + 25
        let index = Int(normalize / 50)
        targetContentOffset.pointee.x = CGFloat(index) * 50 - scrollView.contentInset.left
        print("scrollViewWillEndDragging ", normalize, index, targetContentOffset.pointee.x)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
    }
}

extension CalculatorViewController {
    enum Section: Int {
        case age = 0
        case height
        case weight
        
        var titile: String {
            switch self {
            case .age:
                return "ასაკი"
            case .height:
                return "სიმაღლე"
            case .weight:
                return "წონა"
            }
        }
    }
    
    class Model {
        var items: [Item]
        var delegate: CalculatorViewController
        
        init(items: [Item], delegate: CalculatorViewController) {
            self.items = items
            self.delegate = delegate
            self.items.forEach {
                setup(item: $0)
                createRange(item: $0)
            }
        }
        
        func setup(item: Item) {
            item.scrollView.delegate = delegate
            item.scrollView.decelerationRate = UIScrollViewDecelerationRateFast
        }
        
        func createRange(item: Item) {
            let labelSize: CGFloat = 50
            let range = item.dimention.range
            for index in range.start...range.end {
                let normalizedIndex = index - range.start
                
                let label = UILabel(frame:
                    CGRect(x: CGFloat(normalizedIndex) * labelSize, y: 0, width: labelSize, height: labelSize))
                label.textAlignment = .center
                label.font = ProjectFont.base.with(size: 18)
                label.text = "\(index)"
                label.textColor = UIColor(named: "ABABABFF")
                item.scrollView.addSubview(label)
            }
            
            item.scrollView.contentSize = CGSize(width: CGFloat(item.dimention.count) * labelSize, height: labelSize)
            
            item.scrollView.contentInset.left = (UIScreen.main.bounds.width - labelSize) / 2
            item.scrollView.contentInset.right = (UIScreen.main.bounds.width - labelSize) / 2
            item.scrollView.contentOffset.x = -item.scrollView.contentInset.left
        }
    }
    
    class Item {
        var dimention: Dimension
        
        var section: Section {
            didSet {
                titleLabel.text = section.titile
            }
        }
        
        var scrollView: UIScrollView
        var titleLabel: UILabel
        
        init(section: Section, dimention: Dimension, scrollView: UIScrollView, titleLabel: UILabel) {
            self.section = section
            self.dimention = dimention
            self.scrollView = scrollView
            self.scrollView.tag = section.rawValue
            self.titleLabel = titleLabel
        }
    }
    
    enum Dimension: Int {
        case male = 0
        case female
        case cm
        case inch
        case kg
        case lbs
        
        var range: (start: Int, end: Int) {
            switch self {
            case .male, .female:
                return (1, 100)
            case .cm:
                return (50, 250)
            case .inch:
                return (20, 200)
            case .kg:
                return (10, 200)
            case .lbs:
                return (50, 300)
            }
        }
        
        var count: Int {
            return range.end - range.start + 1
        }
    }
}


















