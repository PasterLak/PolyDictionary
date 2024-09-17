import SwiftUI

struct WordsView: View {
    
    var dictionary: DictionaryModel
    @State private var words: [WordModel] = []
    
    @State private var isPresented: Bool = false
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
            WordsView(dictionary: DictionaryModel(
                name: "Sample Dictionary",
                languages: ["RU","DE"],
                wordCount: 100
            ))
        }
    }
}

