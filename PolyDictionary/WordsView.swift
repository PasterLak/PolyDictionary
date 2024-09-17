import SwiftUI

struct WordsView: View {
    
    var dictionary: DictionaryModel
    @State private var words: [WordModel] = []
    
    @State private var isPresented: Bool = false
    @State private var showingLearning = false
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack {
                    ForEach(Words.WordsDictionary) { wordItem in
                        WordRowView(wordItem: wordItem)
                            .padding(.horizontal)
                    }
                }
            }
            .onAppear {
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
            
            // Добавляем кнопку с иконкой "плюс" в нижнем правом углу
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        // Действие для добавления нового слова
                        isPresented = true
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .padding()
                            .background(Color.purple)
                            .clipShape(Circle())
                            .shadow(radius: 20)
                    }
                    .padding()
                    .sheet(isPresented: $isPresented) {
                        // Передаём текущий словарь в AddWordView
                        AddWordView(dictionary: dictionary)
                    }
                }
            }
        }
    }
}

struct WordsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WordsView(dictionary: DictionaryModel(
                name: "Sample Dictionary",
                languages: ["RU", "DE"],
                wordCount: 100
            ))
            .modelContainer(for: [DictionaryModel.self])
            .environmentObject(Settings())
        }
    }
}

