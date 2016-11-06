import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var controlerWrapperView: UIView!
    
    @IBOutlet weak var ageScrollView: UIScrollView!
    @IBOutlet weak var heightScrollView: UIScrollView!
    @IBOutlet weak var weightScrollView: UIScrollView!
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var model: Model!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.defaultBar()
        
        let item1 = Item(section: .age, dimention: .male, scrollView: ageScrollView, titleLabel: ageLabel)
        let item2 = Item(section: .height, dimention: .cm, scrollView: heightScrollView, titleLabel: heightLabel)
        let item3 = Item(section: .weight, dimention: .kg, scrollView: weightScrollView, titleLabel: weightLabel)
        
        model = Model(items: [item1, item2, item3], delegate: self, resultLabel: resultLabel)
        
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
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        model.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        model.scrollViewDidEndDecelerating(scrollView)
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
        var resultLabel: UILabel
        
        init(items: [Item], delegate: CalculatorViewController, resultLabel: UILabel) {
            self.items = items
            self.delegate = delegate
            self.resultLabel = resultLabel
            self.items.forEach {
                setup(item: $0)
                createRange(item: $0)
            }
            self.calculateResult()
        }
        
        func setup(item: Item) {
            item.scrollView.delegate = delegate
            item.scrollView.decelerationRate = UIScrollViewDecelerationRateFast
        }
        
        func createRange(item: Item) {
            item.scrollView.subviews.forEach { $0.removeFromSuperview() }
            let range = item.dimention.range
            for index in range.start...range.end {
                let normalizedIndex = index - range.start
                
                let label = UILabel(frame:
                    CGRect(x: CGFloat(normalizedIndex) * item.labelWidth, y: 0, width: item.labelWidth, height: item.labelWidth))
                label.textAlignment = .center
                label.font = ProjectFont.base.with(size: 18)
                label.text = "\(index)"
                label.textColor = UIColor(named: "ABABABFF")
                item.scrollView.addSubview(label)
            }
            
            item.scrollView.contentSize = CGSize(width: CGFloat(item.dimention.count) * item.labelWidth, height: item.labelWidth)
            
            item.scrollView.contentInset.left = (UIScreen.main.bounds.width - item.labelWidth) / 2
            item.scrollView.contentInset.right = (UIScreen.main.bounds.width - item.labelWidth) / 2
            item.scrollView.contentOffset.x = -item.scrollView.contentInset.left
        }
        
        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            let section = Section(rawValue: scrollView.tag)!
            items.filter { $0.section == section }.first?.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let section = Section(rawValue: scrollView.tag)!
            items.filter { $0.section == section }.first?.scrollViewDidEndDecelerating(scrollView)
            calculateResult()
        }
        
        func calculateResult() {
            let height = items.filter { $0.section == .height }.first!.selectedNumber / 100
            let weight = items.filter { $0.section == .weight }.first!.selectedNumber
            
            let result = weight / pow(height, 2)
            resultLabel.text = String(format: "%.2f", result)
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
        let labelWidth: CGFloat = 50
        
        init(section: Section, dimention: Dimension, scrollView: UIScrollView, titleLabel: UILabel) {
            self.dimention = dimention
            self.scrollView = scrollView
            self.scrollView.tag = section.rawValue
            self.titleLabel = titleLabel
            self.section = section
        }
        
        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            print("scrollViewWillEndDragging ", targetContentOffset.pointee.x)
            let normalize = max(0, targetContentOffset.pointee.x + scrollView.contentInset.left) + labelWidth / 2
            let index = Int(normalize / labelWidth)
            targetContentOffset.pointee.x = CGFloat(index) * labelWidth - scrollView.contentInset.left
            print("scrollViewWillEndDragging ", normalize, index, targetContentOffset.pointee.x)
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            print("selectedNumber", selectedNumber)
        }
        
        var selectedNumber: CGFloat {
            let normalizedX = scrollView.contentOffset.x + scrollView.contentInset.left
            let index = Int(normalizedX / labelWidth)
            return CGFloat(index + dimention.range.start)
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
                return (19, 99)
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


















