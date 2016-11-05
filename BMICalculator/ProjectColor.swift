import UIKit

enum ProjectColor : String {
    case geocell = "72249CFF"
    case selectedMarker = "00B48CFF"
    static var generalMarker: ProjectColor {
        return .geocell
    }
    case currentLocationMarker = "3B8EDBFF"
    
    case navigationBarTitleColor = "454545FF"
    static var navigationBarShadowColor: ProjectColor {
        return .progressBackgroundStroke
    }
    
    case statusLabel = "8D8D8DFF"
    case statusLabelAmount = "575757FF"
    
    case balanceSection1 = "1595D3FF"
    static var balanceSection2: ProjectColor {
        return .geocell
    }
    
    case progressBackgroundStroke = "E5E5E5FF"
    
    static var selectedNavigationButton: ProjectColor {
        return .geocell
    }
    
    case unSelectedNavigationButton = "767676FF"
    
    case loanAmount = "0095D7FF"
    static var loadPaymendDate: ProjectColor {
        return .navigationBarTitleColor
    }
    
    case selectedMenuItemBackground = "F7F7F7FF"
    
    static var mapNavigationBarShadow: ProjectColor {
        return .selectedMenuItemBackground
    }
    
    static var selectedMenuItemText: ProjectColor {
        return .geocell
    }
    static var selectedMenuItemIcon: ProjectColor {
        return .geocell
    }
    
    
    case unSelectedMenuItemBackground = "FFFFFFFF"
    case unSelectedMenuItemText = "676767FF"
    static var unSelectedMenuItemIcon: ProjectColor {
        return .navigationBarTitleColor
    }
    
    case unFilledSMSCodeLabel = "BABABAFF"
    static var filledSMSCodeLabel: ProjectColor {
        return .navigationBarTitleColor
    }
    
    static var selectedLanguage: ProjectColor {
        return .geocell
    }
    
    static var unSelectedLanguage: ProjectColor {
        return .navigationBarTitleColor
    }
    
    case menuAndPageSeparator = "E0E0E0FF"
    
    static var textFieldPlaceholder: ProjectColor {
        return .unFilledSMSCodeLabel
    }
    
    case mapPolylineBottom = "3468D9FF"
    case mapPolylineMiddle = "3B7BE8FF"
    case mapPolylineTop = "4597FFFF"
    
    static var mapPolyline: (top: UIColor, middle: UIColor, bottom: UIColor) {
        return (
            ProjectColor.mapPolylineTop.color,
            ProjectColor.mapPolylineMiddle.color, 
            ProjectColor.mapPolylineBottom.color)
    }
}




