import Foundation
import SwiftData
import SwiftUI

@Model
public class Word: Identifiable {
    // Поля данных
    public var id: UUID
    public var word: [String: String]
    public var percentage: Int8
    public var tags: [String]
    public var dateAdded: Date

    // Инициализатор
    public init(word: [String: String], percentage: Int8, tags: [String], dateAdded: Date = Date()) {
        self.id = UUID()
        self.word = word
        self.percentage = percentage
        self.tags = tags
        self.dateAdded = dateAdded
    }
    
    // Получение тегов в строковом формате
    public func getTagsAsString() -> String {
        return tags.map { "#\($0)" }.joined(separator: ", ")
    }
    
    // Получение переводов с флагами
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

    // Метод для вывода данных модели в строку
    public func toString() -> String {
        let wordTranslations = word.map { "\($0.key): \($0.value)" }.joined(separator: ", ")
        let tagsString = tags.joined(separator: ", ")
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let dateString = dateFormatter.string(from: dateAdded)
        
        return """
        WordModel:
        - Translations: [\(wordTranslations)]
        - Percentage: \(percentage)%
        - Tags: [\(tagsString)]
        - Date Added: \(dateString)
        """
    }
}

