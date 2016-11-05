import UIKit

class Settings {
    private let userDefaults = UserDefaults.standard
    private static let _settings = Settings()
    
    private init() { }
    
    static var shared: Settings {
        return _settings
    }
    
    var currentLanguage: Language {
        get {
            guard let languageName = userDefaults.value(forKey: "language") as? String, let language = Language(rawValue: languageName)
                else {
                    return .georgian
            }
            
            return language
        }
        set(newLanguage) {
            userDefaults.setValue(newLanguage.rawValue, forKey: "language")
//            UserDefaults(suiteName: "")?.set(newLanguage.rawValue, forKey: "language") თუ ვიჯეტიც არის ან რაიმე შეარდ თარგეთი
        }
    }
    
    var isLanguageSelected: Bool {
        guard let languageName = userDefaults.value(forKey: "language") as? String, let _ = Language(rawValue: languageName)
            else {
                return false
        }
        
        return true
    }
}






