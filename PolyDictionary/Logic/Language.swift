import Foundation

public struct Language: Identifiable, Equatable {
    public var id = UUID()
    var name: String
    var flag: String
    var code: String // "EN", "RU"
    
    // Lazy static property for thread-safe initialization
    public static let allLanguages: [Language] = {
        return [
            Language(name: "Arabic", flag: "🇸🇦", code: "AR"),
            Language(name: "Chinese", flag: "🇨🇳", code: "ZH"),
            Language(name: "English", flag: "🇬🇧", code: "EN"),
            Language(name: "French", flag: "🇫🇷", code: "FR"),
            Language(name: "German", flag: "🇩🇪", code: "DE"),
            Language(name: "Hindi", flag: "🇮🇳", code: "HI"),
            Language(name: "Japanese", flag: "🇯🇵", code: "JA"),
            Language(name: "Portuguese", flag: "🇵🇹", code: "PT"),
            Language(name: "Russian", flag: "🇷🇺", code: "RU"),
            Language(name: "Spanish", flag: "🇪🇸", code: "ES"),
            Language(name: "Ukrainian", flag: "🇺🇦", code: "UK")
        ]
    }()
    
    public static func defaultLanguage() -> Language {
        return Language(name: "English", flag: "🇬🇧", code: "EN")
    }
    
    public static func getLanguageByCode(code: String) -> Language {
        return allLanguages.first { $0.code == code } ?? defaultLanguage()
    }
    
    public static func getLanguageByName(name: String) -> Language {
        return allLanguages.first { $0.name == name } ?? defaultLanguage()
    }
}

