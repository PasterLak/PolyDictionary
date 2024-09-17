import Foundation
import SwiftUI


public struct WordModel: Identifiable {
    public let id = UUID()
    public let word: [String: String]
    public let percentage: Int
    public let tags: [String]
    
    
    public init(word: [String: String], percentage: Int, tags: [String]) {
        self.word = word
        self.percentage = percentage
        self.tags = tags
    }
    
    public func getTagsAsString() -> String
    {
        return tags.map { "#\($0)" }.joined(separator: ", ")
    }
    
    public func getTranslationsWithFlags() -> String {
          
           let remainingTranslations = word.dropFirst()
           
          
           let translationsWithFlags = remainingTranslations.compactMap { (languageCode, translation) -> String? in
               let language = Language.getLanguageByName(name: languageCode)
               return "\(language.flag) \(translation)"
           }
           
          
           return translationsWithFlags.joined(separator: ", ")
       }
}

