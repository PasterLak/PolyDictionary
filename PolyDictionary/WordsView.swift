import SwiftUI


struct WordsView: View {
    
    var dictionary: DictionaryItem
    @State private var words: [WordItem] = []
    private let totalWords = 200
    private let batchSize = 20
    @State private var currentStartIndex = 0
    @State private var currentEndIndex = 0
    
    
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
 
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingLearning = true
                }) {
                    Image(systemName: "lamp.desk")
                        .imageScale(.large)
                }
            }
        }
       
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
        let description =
        "🇩🇪: \(Words.wordsDictionary[word]?.german ?? "error") " +
        "🇷🇺: \(Words.wordsDictionary[word]?.russian ?? "error")"
        let percentage = Int.random(in: 0...100)
        return WordItem(word: word, description: description, percentage: percentage)
    }
    
    private func generateRandomWord() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyz"
        let length = Int.random(in: 3...10)
        return Words.getRandomWord().english
        //return String((0..<length).compactMap { _ in letters.randomElement() })
    }
}


struct WordsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WordsView(dictionary: DictionaryItem(
                name: "Sample Dictionary",
                languages: [Language.getLanguageByCode(code: "RU"), Language.getLanguageByCode(code: "DE")],
                wordCount: 100
            ))
        }
    }
}

