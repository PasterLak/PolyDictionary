import Foundation


public class Words {
    
    
    public static let wordsDictionary: [String: (german: String, russian: String)] = [
        "Apple": ("Apfel", "Яблоко"),
        "Banana": ("Banane", "Банан"),
        "Car": ("Auto", "Автомобиль"),
        "House": ("Haus", "Дом"),
        "Book": ("Buch", "Книга"),
        "School": ("Schule", "Школа"),
        "Teacher": ("Lehrer", "Учитель"),
        "Dog": ("Hund", "Собака"),
        "Cat": ("Katze", "Кошка"),
        "Tree": ("Baum", "Дерево"),
        "Chair": ("Stuhl", "Стул"),
        "Table": ("Tisch", "Стол"),
        "Window": ("Fenster", "Окно"),
        "Phone": ("Telefon", "Телефон"),
        "Pen": ("Stift", "Ручка"),
        "Door": ("Tür", "Дверь"),
        "Water": ("Wasser", "Вода"),
        "Fire": ("Feuer", "Огонь"),
        "Food": ("Essen", "Еда"),
        "Sky": ("Himmel", "Небо")
    ]

   
    public static func getRandomWord() -> (english: String, german: String, russian: String) {
        // Проверяем, что словарь не пустой
        guard !wordsDictionary.isEmpty else {
            return ("No word", "Kein Wort", "Нет слова")
        }
        
        // Получаем случайную пару ключ-значение
        let randomElement = wordsDictionary.randomElement()!
        
        // Возвращаем кортеж: слово на английском, перевод на немецком и русском
        return (english: randomElement.key, german: randomElement.value.german, russian: randomElement.value.russian)
    }
    
    
    public static func getRandomWord0() -> String {
            // Проверяем, что массив не пустой
            guard !WordsDictionary.isEmpty else {
                return "No words available"
            }
            // Получаем случайный элемент из массива
            let randomWordItem = WordsDictionary.randomElement()
            // Возвращаем слово
            return randomWordItem?.word ?? "Unknown word"
        }
    
    public static let WordsDictionary: [WordItem] = [
        WordItem(word: "Apple", description: "A fruit (German: Apfel, Russian: Яблоко)", percentage: 80),
        WordItem(word: "Banana", description: "A yellow fruit (German: Banane, Russian: Банан)", percentage: 90),
        WordItem(word: "Car", description: "A vehicle (German: Auto, Russian: Автомобиль)", percentage: 70),
        WordItem(word: "Swift", description: "A programming language (German: Swift, Russian: Свифт)", percentage: 95),
        WordItem(word: "Computer", description: "A machine (German: Computer, Russian: Компьютер)", percentage: 85),
        WordItem(word: "House", description: "A building (German: Haus, Russian: Дом)", percentage: 80),
        WordItem(word: "Book", description: "An item for reading (German: Buch, Russian: Книга)", percentage: 85),
        WordItem(word: "School", description: "An educational institution (German: Schule, Russian: Школа)", percentage: 90),
        WordItem(word: "Teacher", description: "A person who teaches (German: Lehrer, Russian: Учитель)", percentage: 88),
        WordItem(word: "Dog", description: "A domestic animal (German: Hund, Russian: Собака)", percentage: 75),
        WordItem(word: "Cat", description: "A domestic animal (German: Katze, Russian: Кошка)", percentage: 78),
        WordItem(word: "Tree", description: "A large plant (German: Baum, Russian: Дерево)", percentage: 80),
        WordItem(word: "Chair", description: "A piece of furniture (German: Stuhl, Russian: Стул)", percentage: 85),
        WordItem(word: "Table", description: "A piece of furniture (German: Tisch, Russian: Стол)", percentage: 90),
        WordItem(word: "Window", description: "An opening in a wall (German: Fenster, Russian: Окно)", percentage: 80),
        WordItem(word: "Phone", description: "A communication device (German: Telefon, Russian: Телефон)", percentage: 85),
        WordItem(word: "Pen", description: "A writing tool (German: Stift, Russian: Ручка)", percentage: 87),
        WordItem(word: "Door", description: "An entrance to a room (German: Tür, Russian: Дверь)", percentage: 90),
        WordItem(word: "Water", description: "A liquid (German: Wasser, Russian: Вода)", percentage: 95),
        WordItem(word: "Fire", description: "Combustion (German: Feuer, Russian: Огонь)", percentage: 80),
        WordItem(word: "Food", description: "Something to eat (German: Essen, Russian: Еда)", percentage: 85),
        WordItem(word: "Air", description: "The atmosphere (German: Luft, Russian: Воздух)", percentage: 88),
        WordItem(word: "Sky", description: "The space above the earth (German: Himmel, Russian: Небо)", percentage: 90),
        WordItem(word: "Sun", description: "A star (German: Sonne, Russian: Солнце)", percentage: 85),
        WordItem(word: "Moon", description: "Earth's satellite (German: Mond, Russian: Луна)", percentage: 80),
        WordItem(word: "Star", description: "A celestial body (German: Stern, Russian: Звезда)", percentage: 83),
        WordItem(word: "Mountain", description: "A large landform (German: Berg, Russian: Гора)", percentage: 85),
        WordItem(word: "River", description: "A water stream (German: Fluss, Russian: Река)", percentage: 87),
        WordItem(word: "Forest", description: "A large area with trees (German: Wald, Russian: Лес)", percentage: 88),
        WordItem(word: "Flower", description: "A plant's bloom (German: Blume, Russian: Цветок)", percentage: 90),
        WordItem(word: "Bread", description: "A food item (German: Brot, Russian: Хлеб)", percentage: 95),
        WordItem(word: "Milk", description: "A dairy product (German: Milch, Russian: Молоко)", percentage: 90),
        WordItem(word: "Coffee", description: "A beverage (German: Kaffee, Russian: Кофе)", percentage: 92),
        WordItem(word: "Tea", description: "A beverage (German: Tee, Russian: Чай)", percentage: 85),
        WordItem(word: "Chair", description: "A seat (German: Stuhl, Russian: Стул)", percentage: 80),
        WordItem(word: "Bed", description: "A piece of furniture for sleeping (German: Bett, Russian: Кровать)", percentage: 88),
        WordItem(word: "Mirror", description: "A reflective surface (German: Spiegel, Russian: Зеркало)", percentage: 86),
        WordItem(word: "Road", description: "A path for vehicles (German: Straße, Russian: Дорога)", percentage: 85),
        WordItem(word: "Bridge", description: "A structure to cross water (German: Brücke, Russian: Мост)", percentage: 87),
        WordItem(word: "City", description: "An urban area (German: Stadt, Russian: Город)", percentage: 92),
        WordItem(word: "Village", description: "A small settlement (German: Dorf, Russian: Деревня)", percentage: 83),
        WordItem(word: "Doctor", description: "A medical professional (German: Arzt, Russian: Врач)", percentage: 90),
        WordItem(word: "Nurse", description: "A healthcare worker (German: Krankenschwester, Russian: Медсестра)", percentage: 85),
        WordItem(word: "Engineer", description: "A technical professional (German: Ingenieur, Russian: Инженер)", percentage: 92),
        WordItem(word: "Painter", description: "An artist (German: Maler, Russian: Художник)", percentage: 88),
        WordItem(word: "Writer", description: "A person who writes (German: Schriftsteller, Russian: Писатель)", percentage: 87),
        WordItem(word: "Music", description: "Art form of sound (German: Musik, Russian: Музыка)", percentage: 93)
    ]
}
