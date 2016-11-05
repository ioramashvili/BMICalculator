import UIKit

protocol SegueHandlerType {
    associatedtype SeguaIdentifier: RawRepresentable
}

// ამ მეთოდებზე წვდომა ექნება ყველა UIViewController-ის შთამომავალს რომელიც ინლაინ enum : String -ს აღწერს
extension SegueHandlerType where
    Self: UIViewController,
SeguaIdentifier.RawValue == String {
    
    // სისტემური performSegueWithIdentifier შეფუთვა
    func performSegueWithIdentifier(segueIdentifier: SeguaIdentifier, sender: AnyObject?) {
        performSegue(withIdentifier: segueIdentifier.rawValue, sender: sender)
    }
    
    // გვიბრუნებს SeguaIdentifier-ის case-ს თუ ის შექმნადია გადაწოდებული სტრიქონით
    func identifier(for segue: UIStoryboardSegue) -> SeguaIdentifier {
        guard let id = segue.identifier, let segueIdentifier = SeguaIdentifier(rawValue: id) else {
            fatalError("Error")
        }
        
        return segueIdentifier
    }
}
