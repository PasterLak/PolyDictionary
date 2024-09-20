import Foundation
import SwiftData
import SwiftUI

@Model
public class Word: Identifiable {
    
     public var id: UUID
     var word: [String: String]
     var percentage: Int8
     var tags: [Tag]
     var dateAdded: Date

    public init(word: [String: String], percentage: Int8, dateAdded: Date = Date()) {
        self.id = UUID()
        self.word = word
        self.percentage = percentage
        self.tags = []
        self.dateAdded = dateAdded
    }

    public func getTagsAsString() -> String {
        return tags.map { "#\($0.name)" }.joined(separator: ", ")
    }

    public func getTranslationsWithFlags(for languages: [String]) -> String {
        let remainingLanguages = languages.dropFirst()

        let translationsWithFlags = remainingLanguages.compactMap { languageCode in
            let language = Language.getLanguageByCode(code: languageCode)
            let languageName = language.name

            if let translation = word[languageName] {
                return "\(language.flag) \(translation)"
            }
            return nil
        }

        return translationsWithFlags.joined(separator: ", ")
    }

    public func toString() -> String {
        let wordTranslations = word.map { "\($0.key): \($0.value)" }.joined(separator: ", ")
        //let tagsString = tags.joined(separator: ", ") tags.
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let dateString = dateFormatter.string(from: dateAdded)

        return """
        WordModel:
        - Translations: [\(wordTranslations)]
        - Percentage: \(percentage)%
        - Tags: [\("tagsString")]
        - Date Added: \(dateString)
        """
    }
}

