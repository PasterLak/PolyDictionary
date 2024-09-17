import SwiftUI

struct WordsView: View {
    
    var dictionary: DictionaryModel
    @State private var words: [WordModel] = []
    
    @State private var filteredWords: [WordModel] = []
    @State private var isPresented: Bool = false
    @State private var showingLearning = false
    
    @EnvironmentObject var settings: Settings
    
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .padding(.leading)
                TextField("Search", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .onChange(of: searchText) { newValue in
                        filterWords(searchText: newValue) 
                    }
            }
            .padding(.horizontal)
            
            ZStack {
                ScrollView {
                    LazyVStack {
                        ForEach(filteredWords) { wordItem in
                            WordRowView(wordItem: wordItem)
                                .padding(.horizontal)
                        }
                    }
                }
                .onAppear {
                    words = Words.WordsDictionary
                    filteredWords = words // Изначально отображаем все слова
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
                .background(settings.isDarkMode ? Color(UIColor.systemBackground) : Color(UIColor.secondarySystemBackground))
                .sheet(isPresented: $showingLearning) {
                    LearningView()
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            isPresented = true
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .font(.system(size: 30))
                                .padding()
                                .background(Color.blue)
                                .clipShape(Circle())
                                .shadow(radius: 20)
                                .opacity(0.85)
                        }
                        .padding()
                        .sheet(isPresented: $isPresented) {
                            AddWordView(dictionary: dictionary)
                        }
                    }
                }
            }
        }
        .background(settings.isDarkMode ? Color(UIColor.systemBackground) : Color(UIColor.secondarySystemBackground))
    }
    
    
    private func filterWords(searchText: String) {
        let lowercasedSearchText = searchText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        if lowercasedSearchText.isEmpty {
            filteredWords = words
        } else if lowercasedSearchText == "#" {
            filteredWords = words.filter { !$0.tags.isEmpty }
        } else if lowercasedSearchText.hasPrefix("#") {
            let components = lowercasedSearchText.split(separator: " ").map { String($0) }
            let tags = components.filter { $0.hasPrefix("#") }.map { $0.dropFirst() }

            filteredWords = words.filter { word in
                let wordTags = word.tags.map { $0.lowercased() }
                return tags.allSatisfy { tag in
                    wordTags.contains(where: { $0.hasPrefix(tag) })
                }
            }
        } else if lowercasedSearchText.hasPrefix("%") {
            let percentageQuery = lowercasedSearchText.dropFirst()
            
            if percentageQuery.hasPrefix("<"), let value = Int(percentageQuery.dropFirst()) {
                filteredWords = words.filter { $0.percentage < value }
            } else if percentageQuery.hasPrefix(">"), let value = Int(percentageQuery.dropFirst()) {
                filteredWords = words.filter { $0.percentage > value }
            } else if let exactValue = Int(percentageQuery) {
                filteredWords = words.filter { $0.percentage == exactValue }
            } else {
                filteredWords = []
            }
        } else {
            filteredWords = words.filter { word in
                word.word.values.contains { translation in
                    translation.lowercased().contains(lowercasedSearchText)
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
            .environmentObject(Settings())
            .modelContainer(for: DictionaryModel.self)
        }
    }
}
