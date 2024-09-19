import SwiftUI
import Foundation
import SwiftData

@Model
final class Dictionary: Identifiable, Equatable {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    var name: String
    var languages: [String] // EN
    var wordCount: Int16
    var words: [Word]
    
    
    init(id: String = UUID().uuidString, name: String, languages: [String], wordCount: Int16) {
        self.id = id
        self.name = name
        self.languages = languages
        self.wordCount = wordCount
        words = []
    }
    
    static func == (lhs: Dictionary, rhs: Dictionary) -> Bool {
        return lhs.id == rhs.id
    }
    
   // @DeleteRule(.cascade) var deleteRule : NSDeleteRule
    
}
