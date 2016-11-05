import Foundation
import UIKit

public enum Device {
    
    static var current:(family: Device.Family, name: Device.Name) {
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        var currentDevice: (family: Device.Family, name: Device.Name) = (.other, .other)
        
        switch identifier {
        case "iPod5,1":                                 currentDevice.name = .iPodTouch5
        case "iPod7,1":                                 currentDevice.name = .iPodTouch6
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     currentDevice.name = .iPhone4
        case "iPhone4,1":                               currentDevice.name = .iPhone4s
        case "iPhone5,1", "iPhone5,2":                  currentDevice.name = .iPhone5
        case "iPhone5,3", "iPhone5,4":                  currentDevice.name = .iPhone5c
        case "iPhone6,1", "iPhone6,2":                  currentDevice.name = .iPhone5s
        case "iPhone7,2":                               currentDevice.name = .iPhone6
        case "iPhone7,1":                               currentDevice.name = .iPhone6Plus
        case "iPhone8,1":                               currentDevice.name = .iPhone6s
        case "iPhone8,2":                               currentDevice.name = .iPhone6sPlus
        case "iPhone9,1", "iPhone9,3":                  currentDevice.name = .iPhone7
        case "iPhone9,2", "iPhone9,4":                  currentDevice.name = .iPhone7Plus
        case "iPhone8,4":                               currentDevice.name = .iPhoneSE
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":currentDevice.name = .iPad2
        case "iPad3,1", "iPad3,2", "iPad3,3":           currentDevice.name = .iPad3
        case "iPad3,4", "iPad3,5", "iPad3,6":           currentDevice.name = .iPad4
        case "iPad4,1", "iPad4,2", "iPad4,3":           currentDevice.name = .iPadAir
        case "iPad5,3", "iPad5,4":                      currentDevice.name = .iPadAir2
        case "iPad2,5", "iPad2,6", "iPad2,7":           currentDevice.name = .iPadMini
        case "iPad4,4", "iPad4,5", "iPad4,6":           currentDevice.name = .iPadMini2
        case "iPad4,7", "iPad4,8", "iPad4,9":           currentDevice.name = .iPadMini3
        case "iPad5,1", "iPad5,2":                      currentDevice.name = .iPadMini4
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":currentDevice.name = .iPadPro
        case "AppleTV5,3":                              currentDevice.name = .appleTV
        case "i386", "x86_64":                          currentDevice.name = .simulator
        default:  currentDevice.name = .other
        }
        
        if identifier.contains(Device.Family.iPhone.rawValue) { currentDevice.family = .iPhone }
        else if identifier.contains(Device.Family.iPad.rawValue) { currentDevice.family = .iPad }
        else if identifier.contains(Device.Family.iPod.rawValue) { currentDevice.family = .iPod }
        
        return currentDevice
    }
    
    
    enum Family: String {
        case iPhone
        case iPad
        case iPod
        case other
        
        var isIpad: Bool {
            return self == .iPad
        }
        
        var isIphone: Bool {
            return self == .iPhone
        }
    }
    
    enum ScreenSize {
        case inch4
        case inch4_7
        case inch5_5
        case inchIpad
        
        var names: [Device.Name] {
            switch self {
            case .inch4:
                return [
                    .iPhone4,
                    .iPhone4s,
                    .iPhone5,
                    .iPhone5c,
                    .iPhone5s,
                    .iPhoneSE]
            case .inch4_7:
                return [
                    .iPhone6,
                    .iPhone6s,
                    .iPhone7]
            case .inch5_5:
                return [
                    .iPhone6Plus,
                    .iPhone6sPlus,
                    .iPhone7Plus]
            case .inchIpad:
                return [
                    .appleTV,
                    .iPad2,
                    .iPad3,
                    .iPad4,
                    .iPadAir,
                    .iPadAir2,
                    .iPadMini,
                    .iPadMini2,
                    .iPadMini3,
                    .iPadMini4,
                    .iPadPro]
            }
        }
    }
    
    enum Name {
        
        case iPhone4
        case iPhone4s
        case iPhone5
        case iPhone5c
        case iPhone5s
        case iPhone6
        case iPhone6Plus
        case iPhone6s
        case iPhone6sPlus
        case iPhone7
        case iPhone7Plus
        case iPhoneSE
        
        case iPodTouch5
        case iPodTouch6
        
        case iPad2
        case iPad3
        case iPad4
        case iPadAir
        case iPadAir2
        case iPadMini
        case iPadMini2
        case iPadMini3
        case iPadMini4
        case iPadPro
        
        case appleTV
        case simulator
        
        case other
        
        func isDevice(ofScreenSize screenSize: Device.ScreenSize) -> Bool {
            return screenSize.names.contains(self)
            
        }
        
        func names(forFamily family: Device.Family) -> [Device.Name] {
            switch family {
            case .iPhone:
                return [
                    .iPhone4,
                    .iPhone4s,
                    .iPhone5,
                    .iPhone5c,
                    .iPhone5s,
                    .iPhone6,
                    .iPhone6Plus,
                    .iPhone6s,
                    .iPhone6sPlus,
                    .iPhone7,
                    .iPhone7Plus,
                    .iPhoneSE]
            case .iPod:
                return [
                    .iPodTouch5,
                    .iPodTouch6]
            case .iPad:
                return [
                    .iPad2,
                    .iPad3,
                    .iPad4,
                    .iPadAir,
                    .iPadAir2,
                    .iPadMini,
                    .iPadMini2,
                    .iPadMini3,
                    .iPadMini4,
                    .iPadPro]
            case .other:
                return [
                    .appleTV,
                    .simulator]
            }
        }
    }
    
    enum FontSizeScale: CGFloat {
        case inch4 = 0.9
        case inch4_7 = 1
        case inch5_5 = 1.1
        case inchIpad = 1.3
        
        static func scale(fontSize: CGFloat) -> CGFloat {
            
            var sizeScale: FontSizeScale = .inch4
            let deviceName = Device.current.name
            
            if deviceName.isDevice(ofScreenSize: .inch4_7) {
                sizeScale = .inch4_7
            } else if deviceName.isDevice(ofScreenSize: .inch5_5) {
                sizeScale = .inch4_7 // აბრუნებს ისევ 4.7 ინჩის
            } else if deviceName.isDevice(ofScreenSize: .inchIpad) {
                sizeScale = .inchIpad
            }
            
            return fontSize * sizeScale.rawValue
        }
    }
}












