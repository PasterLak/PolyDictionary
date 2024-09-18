import Foundation

public class Words {
    
    private static let tagsPool = ["nature", "technology", "food", "education", "transport", "art", "science", "emotion", "culture", "animals"]
    

    
    public static func getRandomWord0() -> String {
        guard !WordsDictionary.isEmpty else {
            return "No words available"
        }
        let randomWordItem = WordsDictionary.randomElement()
        return randomWordItem?.word["English"] ?? "Unknown word"
    }
    
    public static let WordsDictionary: [WordModel] = [
        WordModel(word: ["English": "Apple", "German": "Apfel", "Russian": "Яблоко"], percentage: Int8.random(in: 1...100), tags: getRandomTags()),
        WordModel(word: ["English": "Banana", "German": "Banane", "Russian": "Банан"], percentage: Int8.random(in: 1...100), tags: getRandomTags()),
        WordModel(word: ["English": "Pear", "German": "Birne", "Russian": "Груша"], percentage: 76, tags: ["#fruit", "#fresh", "#tropical"]),
            WordModel(word: ["English": "Orange", "German": "Orange", "Russian": "Апельсин"], percentage: Int8.random(in: 1...100), tags: ["#fresh"]),
            WordModel(word: ["English": "Cucumber", "German": "Gurke", "Russian": "Огурец"], percentage: 81, tags: ["#tropical", "#juicy", "#fresh"]),
            WordModel(word: ["English": "Blueberry", "German": "Heidelbeere", "Russian": "Черника"], percentage: 42, tags: ["#fresh", "#organic", "#sweet"]),
            WordModel(word: ["English": "Pineapple", "German": "Ananas", "Russian": "Ананас"], percentage: 15, tags: ["#healthy"]),
            WordModel(word: ["English": "Banana", "German": "Banane", "Russian": "Банан"], percentage: 35, tags: ["#fruit"]),
            WordModel(word: ["English": "Pomegranate", "German": "Granatapfel", "Russian": "Гранат"], percentage: 33, tags: ["#sweet", "#fresh", "#juicy"]),
            WordModel(word: ["English": "Apple", "German": "Apfel", "Russian": "Яблоко"], percentage: Int8.random(in: 1...100), tags: ["#juicy", "#organic"]),
            WordModel(word: ["English": "Apricot", "German": "Aprikose", "Russian": "Абрикос"], percentage: 18, tags: ["#juicy"]),
            WordModel(word: ["English": "Cherry", "German": "Kirsche", "Russian": "Вишня"], percentage: 35, tags: ["#sweet", "#fresh", "#juicy"]),
            WordModel(word: ["English": "Peach", "German": "Pfirsich", "Russian": "Персик"], percentage: 88, tags: ["#tropical"]),
            WordModel(word: ["English": "Watermelon", "German": "Wassermelone", "Russian": "Арбуз"], percentage: 22, tags: ["#healthy", "#fresh", "#fruit"]),
            WordModel(word: ["English": "Strawberry", "German": "Erdbeere", "Russian": "Клубника"], percentage: 10, tags: ["#fruit", "#fresh", "#sweet"]),
            WordModel(word: ["English": "Lemon", "German": "Zitrone", "Russian": "Лимон"], percentage: Int8.random(in: 1...100), tags: ["#sweet", "#fresh"]),
            WordModel(word: ["English": "Mango", "German": "Mango", "Russian": "Манго"], percentage: 17, tags: ["#juicy", "#fruit"]),
            WordModel(word: ["English": "Plum", "German": "Pflaume", "Russian": "Слива"], percentage: 26, tags: ["#fruit", "#healthy", "#tropical"]),
            WordModel(word: ["English": "Melon", "German": "Melone", "Russian": "Дыня"], percentage: 58, tags: ["#juicy", "#fresh"]),
            WordModel(word: ["English": "Coconut", "German": "Kokosnuss", "Russian": "Кокос"], percentage: 36, tags: ["#tropical", "#fresh", "#healthy"]),
            WordModel(word: ["English": "Grapes", "German": "Trauben", "Russian": "Виноград"], percentage: 100, tags: ["#sweet", "#healthy", "#organic"]),
            WordModel(word: ["English": "Kiwi", "German": "Kiwi", "Russian": "Киви"], percentage: 100, tags: ["#organic", "#healthy", "#juicy"])

    ]
    
    private static func getRandomTags() -> [String] {
        let tagsCount = Int.random(in: 0..<tagsPool.count/2)
        return Array(tagsPool.shuffled().prefix(tagsCount))
    }
}
