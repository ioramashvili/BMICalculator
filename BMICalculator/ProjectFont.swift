import UIKit

enum ProjectFont: String {
    case base = "MyGeocell-Regular"
    
    case notosansbold = "NotoSans-Bold"
    case notosansregular = "NotoSans"
    case bpgPhoneSans = "BPGPhoneSans"
    case bpgPhoneSansBold = "BPGPhoneSans-Bold"
    case bpgArial2010 = "BPGArial2010"
    case bpgGEL = "!BPGGEL"
    
    func with(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
    
    static func printFontNames() {
        for family in UIFont.familyNames {
            print("\(family)")
            
            for name in UIFont.fontNames(forFamilyName: family) {
                print("   \(name)")
            }
        }
    }
}

// გამოყენების მაგალითი

// let font = UIFont(name: ProjectFont.BPGExcelsior.rawValue, size: 15)
