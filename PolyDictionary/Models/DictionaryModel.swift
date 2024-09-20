import SwiftUI
import Foundation
import SwiftData

@Model
final class DictionaryModel: Identifiable, Equatable {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    var name: String
    var languages: [String]
    var wordCount: Int16
    
    @Relationship(deleteRule: .cascade)
    var words: [Word]

    init(id: String = UUID().uuidString, name: String, languages: [String], wordCount: Int16) {
        self.id = id
        self.name = name
        self.languages = languages
        self.wordCount = wordCount
        self.words = []
        self.wordCount = Int16(words.count)
    }

    static func == (lhs: DictionaryModel, rhs: DictionaryModel) -> Bool {
        return lhs.id == rhs.id
    }
}

