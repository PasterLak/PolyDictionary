import SwiftUI

struct WordsView: View {
    @Bindable var dictionary: DictionaryModel

    @State private var filteredWords: [Word] = []
    @State private var isPresented: Bool = false
    @State private var showingLearning = false
    @State private var showingSortOptions = false
    @State private var selectedSortOption: SortOption = .nameAscending
    @State private var showAddedMessage = false

    @EnvironmentObject var settings: Settings

    @State private var searchText = ""

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .padding(.leading)

                if showAddedMessage {
                    WordAddedMessage()
                } else {
                    TextField("Search", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .onChange(of: searchText) { newValue in
                            filterWords(searchText: newValue)
                        }
                }

                Button(action: {
                    showingSortOptions = true
                }) {
                    Image(systemName: "slider.horizontal.3")
                        .padding(.trailing)
                }
            }
            .padding(.horizontal)

            ZStack {
                List {
                    ForEach(filteredWords) { wordItem in
                        WordRowView(wordModel: wordItem, dictionary: dictionary)
                            
                            .padding(.horizontal)
                    }
                }
                .onAppear {
                    loadSortOption()
                    filteredWords = dictionary.words
                    sortWords(option: selectedSortOption)
                }
                .onChange(of: dictionary.words) { newWords in
                    filteredWords = newWords
                    sortWords(option: selectedSortOption)
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
                    TrainingView()
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
                            AddWordView(dictionary: dictionary) { newWord in
                                showMessage()
                            }
                        }
                    }
                }
            }
            .background(settings.isDarkMode ? Color(UIColor.systemBackground) : Color(UIColor.secondarySystemBackground))
            .sheet(isPresented: $showingSortOptions, onDismiss: {
                sortWords(option: selectedSortOption)
                saveSortOption()
            }) {
                SortOptionsView(selectedSortOption: $selectedSortOption)
            }
        }
    }

    private func showMessage() {
        showAddedMessage = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                showAddedMessage = false
            }
        }
    }

    private func filterWords(searchText: String) {
        let lowercasedSearchText = searchText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        if lowercasedSearchText.isEmpty {
            filteredWords = dictionary.words
            sortWords(option: selectedSortOption)
        } else if lowercasedSearchText == "#" {
            filteredWords = dictionary.words.filter { !$0.tags.isEmpty }
        } else if lowercasedSearchText.hasPrefix("#") {
            let components = lowercasedSearchText.split(separator: " ").map { String($0) }
            let tags = components.filter { $0.hasPrefix("#") }.map { $0.dropFirst() }

            filteredWords = dictionary.words.filter { word in
                let wordTags = word.tags.map { $0.name.lowercased() }
                return tags.allSatisfy { tag in
                    wordTags.contains(where: { $0.hasPrefix(tag) })
                }
            }
        } else if lowercasedSearchText.hasPrefix("%") {
            let percentageQuery = lowercasedSearchText.dropFirst()

            if percentageQuery.hasPrefix("<"), let value = Int(percentageQuery.dropFirst()) {
                filteredWords = dictionary.words.filter { $0.percentage < value }
            } else if percentageQuery.hasPrefix(">"), let value = Int(percentageQuery.dropFirst()) {
                filteredWords = dictionary.words.filter { $0.percentage > value }
            } else if let exactValue = Int(percentageQuery) {
                filteredWords = dictionary.words.filter { $0.percentage == exactValue }
            } else {
                filteredWords = []
            }
        } else {
            filteredWords = dictionary.words.filter { word in
                word.word.values.contains { translation in
                    translation.lowercased().contains(lowercasedSearchText)
                }
            }
        }
        sortWords(option: selectedSortOption)
    }

    private func sortWords(option: SortOption) {
        selectedSortOption = option
        switch option {
        case .percentageAscending:
            filteredWords.sort { $0.percentage < $1.percentage }
        case .percentageDescending:
            filteredWords.sort { $0.percentage > $1.percentage }
        case .nameAscending:
            filteredWords.sort { $0.word.first?.value.lowercased() ?? "" < $1.word.first?.value.lowercased() ?? "" }
        case .nameDescending:
            filteredWords.sort { $0.word.first?.value.lowercased() ?? "" > $1.word.first?.value.lowercased() ?? "" }
        case .dateAddedAscending:
            filteredWords.sort { $0.dateAdded < $1.dateAdded }
        case .dateAddedDescending:
            filteredWords.sort { $0.dateAdded > $1.dateAdded }
        }
    }

    private func saveSortOption() {
        UserDefaults.standard.set(selectedSortOption.rawValue, forKey: "selectedSortOption")
    }

    private func loadSortOption() {
        if let savedSortOption = UserDefaults.standard.value(forKey: "selectedSortOption") as? Int,
           let option = SortOption(rawValue: savedSortOption) {
            selectedSortOption = option
        }
    }
}

public enum SortOption: Int {
    case percentageAscending
    case percentageDescending
    case nameAscending
    case nameDescending
    case dateAddedAscending
    case dateAddedDescending
}

