import Foundation


public struct WordItem: Identifiable {
    public let id = UUID()  
    public let word: String
    public let description: String
    public let percentage: Int
    
    public init(word: String, description: String, percentage: Int) {
        self.word = word
        self.description = description
        self.percentage = percentage
    }
}

