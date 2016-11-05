import Foundation

extension Bool {
    mutating func reverse() {
        self = !self
    }
    
    func reversed() -> Bool {
        return !self
    }
}
