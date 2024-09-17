import Foundation

public struct Language: Identifiable, Equatable, Hashable {
    public var id = UUID()
    var name: String
    var flag: String
    var code: String // "EN", "RU"
    var rating : Int8
    
    public func hash(into hasher: inout Hasher) {
            hasher.combine(name)
            hasher.combine(code)
        }
    
    public static let allLanguages: [Language] = {
        return [
            Language(name: "Arabic", flag: "🇸🇦", code: "AR", rating: Int8(60)),
            Language(name: "Chinese (Simplified)", flag: "🇨🇳", code: "ZH-Hans", rating: Int8(75)),
            Language(name: "Chinese (Traditional)", flag: "🇹🇼", code: "ZH-Hant", rating: Int8(60)),
            Language(name: "English", flag: "🇺🇸", code: "EN", rating: Int8(100)),
            Language(name: "French", flag: "🇫🇷", code: "FR", rating: Int8(85)),
            Language(name: "German", flag: "🇩🇪", code: "DE", rating: Int8(80)),
            Language(name: "Hindi", flag: "🇮🇳", code: "HI", rating: Int8(50)),
            Language(name: "Japanese", flag: "🇯🇵", code: "JA", rating: Int8(70)),
            Language(name: "Portuguese", flag: "🇵🇹", code: "PT", rating: Int8(65)),
            Language(name: "Russian", flag: "🇷🇺", code: "RU", rating: Int8(75)),
            Language(name: "Spanish", flag: "🇪🇸", code: "ES", rating: Int8(95)),
            Language(name: "Ukrainian", flag: "🇺🇦", code: "UK", rating: Int8(40)),
            Language(name: "Italian", flag: "🇮🇹", code: "IT", rating: Int8(70)),
            Language(name: "Korean", flag: "🇰🇷", code: "KO", rating: Int8(80)),
            Language(name: "Turkish", flag: "🇹🇷", code: "TR", rating: Int8(60)),
            Language(name: "Dutch", flag: "🇳🇱", code: "NL", rating: Int8(55)),
            Language(name: "Greek", flag: "🇬🇷", code: "EL", rating: Int8(45)),
            Language(name: "Swedish", flag: "🇸🇪", code: "SV", rating: Int8(50)),
            Language(name: "Norwegian", flag: "🇳🇴", code: "NO", rating: Int8(50)),
            Language(name: "Polish", flag: "🇵🇱", code: "PL", rating: Int8(55)),
            Language(name: "Danish", flag: "🇩🇰", code: "DA", rating: Int8(45)),
            Language(name: "Finnish", flag: "🇫🇮", code: "FI", rating: Int8(40)),
            Language(name: "Hebrew", flag: "🇮🇱", code: "HE", rating: Int8(35)),
            Language(name: "Thai", flag: "🇹🇭", code: "TH", rating: Int8(50)),
            Language(name: "Indonesian", flag: "🇮🇩", code: "ID", rating: Int8(55)),
            Language(name: "Malay", flag: "🇲🇾", code: "MS", rating: Int8(40)),
            Language(name: "Czech", flag: "🇨🇿", code: "CS", rating: Int8(40)),
            Language(name: "Hungarian", flag: "🇭🇺", code: "HU", rating: Int8(35)),
            Language(name: "Vietnamese", flag: "🇻🇳", code: "VI", rating: Int8(50)),
            Language(name: "Romanian", flag: "🇷🇴", code: "RO", rating: Int8(45)),
            Language(name: "Slovak", flag: "🇸🇰", code: "SK", rating: Int8(35)),
            Language(name: "Bulgarian", flag: "🇧🇬", code: "BG", rating: Int8(35)),
            Language(name: "Croatian", flag: "🇭🇷", code: "HR", rating: Int8(35)),
            Language(name: "Serbian", flag: "🇷🇸", code: "SR", rating: Int8(35)),
            Language(name: "Catalan", flag: "🇦🇩", code: "CA", rating: Int8(45)),
            Language(name: "Lithuanian", flag: "🇱🇹", code: "LT", rating: Int8(30)),
            Language(name: "Latvian", flag: "🇱🇻", code: "LV", rating: Int8(30)),
            Language(name: "Estonian", flag: "🇪🇪", code: "ET", rating: Int8(25))
        ]
    }()


    
    public static func defaultLanguage() -> Language {
        return Language(name: "English", flag: "🇬🇧", code: "EN", rating: Int8(100))
    }
    
    public static func getLanguageByCode(code: String) -> Language {
        return allLanguages.first { $0.code == code } ?? defaultLanguage()
    }
    
    public static func getLanguageByName(name: String) -> Language {
        return allLanguages.first { $0.name == name } ?? defaultLanguage()
    }
}

