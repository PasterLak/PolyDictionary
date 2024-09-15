import SwiftUI


// Модель для элемента слова
struct WordItem: Identifiable {
    let id = UUID()
    let word: String
    let description: String
    let percentage: Int
}

// Представление для каждой строки слова
struct WordRowView: View {
    let wordItem: WordItem

    var body: some View {
        HStack {
            
            /*Image(systemName: randomIcon())
                .resizable()
                .frame(width: 55, height: 40)
                .padding(.trailing, 8)*/

            // Текст в центре
            VStack(alignment: .leading) {
           
                    Text(wordItem.word)
                        .font(.headline)
               
                
                
                Text(wordItem.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("#tag #imp")
                    .font(.caption).foregroundColor(.yellow)
        
            }
            Spacer()

            // Процент справа в кружке
            ZStack {
                Circle()
                    .stroke(colorForPercentage(wordItem.percentage), lineWidth: 2)
                    .frame(width: 50, height: 50)
                if wordItem.percentage < 100
                {
                    Text("\(wordItem.percentage)%")
                        .font(.headline)
                }
                else
                {
                    Image(systemName: "checkmark.circle.fill")
                        
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.purple)
                        //.padding(.trailing, 8)
                       
                }
                
               
            }
        }
        .padding(.vertical, 8)
    }

    func colorForPercentage(_ percentage: Int) -> Color {
        switch percentage {
        case ..<20:
            return Color.red
        case 20...40:
            return Color.orange
        case 40...60:
            return Color.yellow
        case 60...80:
            return Color.green
        case 80...95:
            return Color.blue
        default:
            return Color.purple
        }
    }

    func randomIcon() -> String {
        let icons = ["globe", "envelope.fill", "mail", "creditcard"]
        return icons.randomElement() ?? "questionmark"
    }
}


struct LearningView: View {
    var body: some View {
        NavigationView {
            VStack {
                /*Text("Learning")
                    .font(.largeTitle)
                    .padding()
                Spacer()*/
            }
            .navigationBarTitle("Learning", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    //Button("Закрыть") {
                        // Автоматически закрывается свайпом вниз или кнопкой "Закрыть"
                    //}
                }
            }
        }
    }
}

// Основное представление для отображения списка слов
struct WordsView: View {
    var dictionary: DictionaryItem
    @State private var words: [WordItem] = []
    private let totalWords = 200
    private let batchSize = 20
    @State private var currentStartIndex = 0
    @State private var currentEndIndex = 0

    // Состояние для управления отображением модального окна
    @State private var showingLearning = false
    
    func Close()
    {
        
    }

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(words) { wordItem in
                    WordRowView(wordItem: wordItem)
                        .padding(.horizontal)
                        .onAppear {
                            if wordItem.id == words.last?.id {
                                loadMoreWords(direction: .down)
                            }
                            if wordItem.id == words.first?.id {
                                loadMoreWords(direction: .up)
                            }
                        }
                }
            }
        }
        .onAppear {
            loadMoreWords(direction: .down)
        }
        .navigationBarTitle(dictionary.name, displayMode: .inline)
        .toolbar {
            // Кнопка "Home" в нижней панели
            /*ToolbarItem(placement: .bottomBar) {
                Button(action: {
                    // Возвращаемся к списку словарей
                    if let window = UIApplication.shared.windows.first {
                        window.rootViewController?.dismiss(animated: true, completion: nil)
                    }
                }) {
                    Text("Home")
                }
            }*/
            
            // Кнопка с иконкой глобуса в верхнем правом углу
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingLearning = true
                }) {
                    Image(systemName: "lamp.desk")
                        .imageScale(.large)
                }
            }
        }
        // Модальное представление "LearningView"
        .sheet(isPresented: $showingLearning) {
            LearningView()
        }
    }

    enum ScrollDirection {
        case up
        case down
    }

    private func loadMoreWords(direction: ScrollDirection) {
        switch direction {
        case .down:
            guard currentEndIndex < totalWords else { return }
            let remainingWords = totalWords - currentEndIndex
            let numberOfWordsToAdd = min(batchSize, remainingWords)
            let newWords = (0..<numberOfWordsToAdd).map { _ in generateWordItem() }
            words.append(contentsOf: newWords)
            currentEndIndex += numberOfWordsToAdd
        case .up:
            guard currentStartIndex > 0 else { return }
            let numberOfWordsToAdd = min(batchSize, currentStartIndex)
            let newWords = (0..<numberOfWordsToAdd).map { _ in generateWordItem() }
            words.insert(contentsOf: newWords, at: 0)
            currentStartIndex -= numberOfWordsToAdd
        }
    }

    private func generateWordItem() -> WordItem {
        let word = generateRandomWord()
        let description = "🇬🇧: \(word)" + " 🇫🇷: \(word)"
        let percentage = Int.random(in: 0...100)
        return WordItem(word: word, description: description, percentage: percentage)
    }

    private func generateRandomWord() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyz"
        let length = Int.random(in: 3...10)
        return String((0..<length).compactMap { _ in letters.randomElement() })
    }
}


struct WordsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WordsView(dictionary: DictionaryItem(
                name: "Sample Dictionary",
                languages: [allLanguages[0], allLanguages[1]],
                wordCount: 100
            ))
        }
    }
}

