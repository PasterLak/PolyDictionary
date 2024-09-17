import Foundation

public class Words {

    private static let tagsPool = ["nature", "technology", "food", "education", "transport", "art", "science", "emotion", "culture", "animals"]
    
    public static func getRandomWord() -> (english: String, german: String, russian: String) {
        guard !WordsDictionary.isEmpty else {
            return ("No word", "Kein Wort", "Нет слова")
        }
        
        let randomElement = WordsDictionary.randomElement()!
        return (english: randomElement.word["English"] ?? "Unknown",
                german: randomElement.word["German"] ?? "Unknown",
                russian: randomElement.word["Russian"] ?? "Unknown")
    }
    
    public static func getRandomWord0() -> String {
        guard !WordsDictionary.isEmpty else {
            return "No words available"
        }
        let randomWordItem = WordsDictionary.randomElement()
        return randomWordItem?.word["English"] ?? "Unknown word"
    }
    
    public static let WordsDictionary: [WordModel] = [
        WordModel(word: ["English": "Apple", "German": "Apfel", "Russian": "Яблоко"], percentage: Int.random(in: 1...100), tags: getRandomTags()),
        WordModel(word: ["English": "Banana", "German": "Banane", "Russian": "Банан"], percentage: Int.random(in: 90...100), tags: getRandomTags()),
        WordModel(word: ["English": "Car", "German": "Auto", "Russian": "Автомобиль"], percentage: Int.random(in: 1...100), tags: getRandomTags()),
        WordModel(word: ["English": "Swift", "German": "Swift", "Russian": "Свифт"], percentage: Int.random(in: 1...100), tags: getRandomTags()),
        WordModel(word: ["English": "Computer", "German": "Computer", "Russian": "Компьютер"], percentage: Int.random(in: 1...100), tags: getRandomTags()),
        WordModel(word: ["English": "House", "German": "Haus", "Russian": "Дом"], percentage: Int.random(in: 1...100), tags: getRandomTags()),
        WordModel(word: ["English": "Book", "German": "Buch", "Russian": "Книга"], percentage: Int.random(in: 99...100), tags: getRandomTags()),
        WordModel(word: ["English": "School", "German": "Schule", "Russian": "Школа"], percentage: Int.random(in: 99...100), tags: getRandomTags()),
        WordModel(word: ["English": "Teacher", "German": "Lehrer", "Russian": "Учитель"], percentage: Int.random(in: 1...100), tags: getRandomTags()),
        WordModel(word: ["English": "Dog", "German": "Hund", "Russian": "Собака"], percentage: Int.random(in: 1...100), tags: getRandomTags()),
        WordModel(word: ["English": "Cat", "German": "Katze", "Russian": "Кошка"], percentage: Int.random(in: 1...100), tags: getRandomTags()),
        WordModel(word: ["English": "Apple", "German": "Apfel", "Russian": "Яблоко"], percentage: Int.random(in: 1...100), tags: getRandomTags()),
        WordModel(word: ["English": "Banana", "German": "Banane", "Russian": "Банан"], percentage: Int.random(in: 1...100), tags: getRandomTags()),
        WordModel(word: ["English": "Car", "German": "Auto", "Russian": "Автомобиль"], percentage: Int.random(in: 1...100), tags: getRandomTags()),
        WordModel(word: ["English": "Swift", "German": "Swift", "Russian": "Свифт"], percentage: Int.random(in: 1...100), tags: getRandomTags()),
        WordModel(word: ["English": "Computer", "German": "Computer", "Russian": "Компьютер"], percentage: Int.random(in: 1...100), tags: getRandomTags()),
        WordModel(word: ["English": "House", "German": "Haus", "Russian": "Дом"], percentage: Int.random(in: 1...100), tags: getRandomTags()),
        WordModel(word: ["English": "Book", "German": "Buch", "Russian": "Книга"], percentage: Int.random(in: 1...100), tags: getRandomTags()),
        WordModel(word: ["English": "School", "German": "Schule", "Russian": "Школа"], percentage: Int.random(in: 1...100), tags: getRandomTags()),
        WordModel(word: ["English": "Teacher", "German": "Lehrer", "Russian": "Учитель"], percentage: Int.random(in: 1...100), tags: getRandomTags()),
        WordModel(word: ["English": "Dog", "German": "Hund", "Russian": "Собака"], percentage: Int.random(in: 1...100), tags: getRandomTags()),
        WordModel(word: ["English": "Cat", "German": "Katze", "Russian": "Кошка"], percentage: Int.random(in: 1...100), tags: getRandomTags())
        
    ]
    
    private static func getRandomTags() -> [String] {
        let tagsCount = Int.random(in: 0..<tagsPool.count/2)
        return Array(tagsPool.shuffled().prefix(tagsCount))
    }
}
