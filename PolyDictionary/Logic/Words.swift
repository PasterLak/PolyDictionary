import Foundation

public class Words {
    
    private static let tagsPool = ["nature", "technology", "food", "education", "transport", "art", "science", "emotion", "culture", "animals"]
    
    
    
    /*public static func getRandomWord0() -> String {
        guard !WordsDictionary.isEmpty else {
            return "No words available"
        }
        let randomWordItem = WordsDictionary.randomElement()
        return randomWordItem?.word["English"] ?? "Unknown word"
    }*/
    
    
    
    private static func getRandomTags() -> [String] {
        let tagsCount = Int.random(in: 0..<tagsPool.count/2)
        return Array(tagsPool.shuffled().prefix(tagsCount))
    }
}
