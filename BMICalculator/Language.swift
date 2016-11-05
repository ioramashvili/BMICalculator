enum Language: String {
    case georgian = "ge"
    case english = "en"
    
    static var all: [Language] {
        return [.georgian, .english]
    }
    
    var rawString: String {
        switch self {
        case .georgian:
            return "ქართული"
        case .english:
            return "English"
        }
    }
}
