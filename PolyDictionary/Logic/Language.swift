import Foundation
import SwiftUI


struct Language: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var flag: String
    var code: String // "EN", "RU"
}


let allLanguages: [Language] = [
    Language(name: "English", flag: "🇬🇧", code: "EN"),
    Language(name: "Russian", flag: "🇷🇺", code: "RU"),
    Language(name: "French", flag: "🇫🇷", code: "FR"),
    Language(name: "Spanish", flag: "🇪🇸", code: "ES"),
    Language(name: "German", flag: "🇩🇪", code: "DE"),
    Language(name: "Ukranian", flag: "🇺🇦", code: "UK"),
  
  
]
