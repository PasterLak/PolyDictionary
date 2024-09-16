import SwiftUI

struct WordsView: View {
    
    var dictionary: DictionaryItem
    @State private var words: [WordItem] = []
    
    @State private var showingLearning = false
    
    var body: some View {
        ScrollView {
            LazyVStack {
                // Проходим по уже существующим словам
                ForEach(Words.WordsDictionary) { wordItem in
                    WordRowView(wordItem: wordItem)
                        .padding(.horizontal)
                }
            }
        }
        .onAppear {
            // Загружаем слова при загрузке представления
            words = Words.WordsDictionary
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

