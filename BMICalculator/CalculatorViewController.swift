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
    
    @IBOutlet weak var genderLabelSegmentedControl: CustomSegmented!
    @IBOutlet weak var heightLabelSegmentedControl: CustomSegmented!
    @IBOutlet weak var weightLabelSegmentedControl: CustomSegmented!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var model: Model!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.defaultBar()
        
        let item1 = Item(
            section: .age,
            scrollView: ageScrollView,
            titleLabel: ageLabel,
            segmentedControl: genderLabelSegmentedControl)
        let item2 = Item(
            section: .height,
            scrollView: heightScrollView,
            titleLabel: heightLabel,
            segmentedControl: heightLabelSegmentedControl)
        let item3 = Item(
            section: .weight,
            scrollView: weightScrollView,
            titleLabel: weightLabel,
            segmentedControl: weightLabelSegmentedControl)
        
        model = Model(items: [item1, item2, item3], delegate: self, resultLabel: resultLabel)
        
        createGradinet()
    }
    
    func segmentedValueChaged(sender: CustomSegmented) {
        model.segmentedValueChaged(sender: sender)
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
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        
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
        
        var dimensions: (start: Dimension, end: Dimension) {
            switch self {
            case .age:
                return (.female, .male)
            case .height:
                return (.cm, .inch)
            case .weight:
                return (.kg, .lbs)
            }
        }
    }
    
    class Model {
        var items: [Item]
        weak var delegate: CalculatorViewController?
        var resultLabel: UILabel
        
        init(items: [Item], delegate: CalculatorViewController?, resultLabel: UILabel) {
            self.items = items
            self.delegate = delegate
            self.resultLabel = resultLabel
            self.items.forEach {
                setup(item: $0)
                createRange(item: $0)
                $0.segmentedControl.addTarget(delegate, action: #selector(delegate?.segmentedValueChaged(sender:)), for: .valueChanged)
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
            
            var lastSelectedNumber = Item.getSavedData(onSection: item.section).selectedNumber
            lastSelectedNumber = (range.start...range.end).contains(lastSelectedNumber) ? lastSelectedNumber : 0
            let lastSelectedIndex = max(lastSelectedNumber - range.start, 0)
            
            print("lastSelectedIndex in section ", item.section.titile, item.dimention, lastSelectedIndex)
            
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
//            item.scrollView.contentOffset.x = -item.scrollView.contentInset.left
            
            item.scrollView.contentOffset.x = CGFloat(lastSelectedIndex) * item.labelWidth - item.scrollView.contentInset.left
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
            
            DispatchQueue.global(qos: .userInitiated).async {
                self.items.forEach {
                    $0.save()
                }
            }
        }
        
        func getItem(onSection section: Section) -> Item {
            return items.first(where: { $0.section == section })!
        }
        
        func segmentedValueChaged(sender: CustomSegmented) {
            guard let section = Section(rawValue: sender.tag) else {
                return
            }
            
            switch section {
            case .age:
                print("age")
                getItem(onSection: .age).dimention = sender.getSelectedDimension
            case .height, .weight:
                let selectedIndex = sender.selectedSegmentIndex
                let heightSectionItem = getItem(onSection: .height)
                let weigthSectionItem = getItem(onSection: .weight)
                
                heightSectionItem.segmentedControl.selectedSegmentIndex = selectedIndex
                weigthSectionItem.segmentedControl.selectedSegmentIndex = selectedIndex
                
                heightSectionItem.dimention = heightSectionItem.segmentedControl.getSelectedDimension
                weigthSectionItem.dimention = weigthSectionItem.segmentedControl.getSelectedDimension
                
                [heightSectionItem, weigthSectionItem].forEach {
                    createRange(item: $0)
                }
            }
            
            calculateResult()
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
        var segmentedControl: CustomSegmented
        var titleLabel: UILabel
        let labelWidth: CGFloat = 50
        
        init(section: Section, scrollView: UIScrollView, titleLabel: UILabel, segmentedControl: CustomSegmented) {
            self.dimention = Item.getSavedData(onSection: section).dimension
            self.scrollView = scrollView
            self.scrollView.tag = section.rawValue
            self.titleLabel = titleLabel
            self.segmentedControl = segmentedControl
            self.segmentedControl.dimensions = section.dimensions
            self.segmentedControl.selectedSegmentIndex = section.dimensions.start == dimention ? 0 : 1
            self.segmentedControl.tag = section.rawValue
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
        
        func save() {
            UserDefaults.standard.set(dimention.rawValue, forKey: "\(section.rawValue)-dimension")
            UserDefaults.standard.set(selectedNumber, forKey: "\(section.rawValue)-selectedNumber")
            print("Save section ", section.titile, selectedNumber, dimention.title)
        }
        
        static func getSavedData(onSection section: Section) -> (dimension: Dimension, selectedNumber: Int) {
            guard let dimensionValue = UserDefaults.standard.object(forKey: "\(section.rawValue)-dimension") as? Int,
                let selectedNumber = UserDefaults.standard.object(forKey: "\(section.rawValue)-selectedNumber") as? Int,
                let dimension = Dimension(rawValue: dimensionValue) else {
                return (section.dimensions.start, 0)
            }
            print("Saved ", dimension.title, selectedNumber, section.titile)
            return (dimension, selectedNumber)
        }
    }
    
    enum Dimension: Int {
        case female = 0
        case male
        case cm
        case inch
        case kg
        case lbs
        case none
        
        var range: (start: Int, end: Int) {
            switch self {
            case .female, .male:
                return (1, 100)
            case .cm:
                return (50, 250)
            case .inch:
                return (19, 99)
            case .kg:
                return (10, 200)
            case .lbs:
                return (50, 300)
            case .none:
                return (0, 0)
            }
        }
        
        var title: String {
            switch self {
            case .female:
                return "მდედრ"
            case .male:
                return "მამრ"
            case .cm:
                return "სმ"
            case .inch:
                return "ინჩ"
            case .kg:
                return "კგ"
            case .lbs:
                return "ლბს"
            case .none:
                return "none"
            }
        }
        
        var count: Int {
            return range.end - range.start + 1
        }
    }
}

class CustomSegmented: UISegmentedControl {
    var dimensions : (start: CalculatorViewController.Dimension, end: CalculatorViewController.Dimension) = (.none, .none)
    var getSelectedDimension: CalculatorViewController.Dimension {
        return selectedSegmentIndex == 0 ? dimensions.start : dimensions.end
    }
}














