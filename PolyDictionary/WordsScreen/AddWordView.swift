import SwiftUI

struct AddWordView: View {
    
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = WordViewModel()
    //@StateObject private var dictionaryViewModel = DictionaryViewModel()
    
    var dictionary: Dictionary
    @State private var wordTranslations: [String: String] = [:]
    @State private var selectedTags: [String] = []
    @State private var isTagSelectorPresented = false
    @Environment(\.dismiss) var dismiss
    
    var onAddWord: (Word) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Translations")) {
                    ForEach(dictionary.languages, id: \.self) { language in
                        TextField("Word in \(Language.getLanguageByCode(code: language).name)", text: Binding(
                            get: { wordTranslations[language] ?? "" },
                            set: { wordTranslations[language] = $0 }
                        ))
                        .autocapitalization(.none)
                    }
                }
                
                Section(header: Text("Tags")) {
                    HStack {
                        Text("Selected Tags:")
                        Spacer()
                        Text(selectedTags.joined(separator: ", "))
                            .foregroundColor(.gray)
                    }
                    Button(action: {
                        isTagSelectorPresented = true
                    }) {
                        Text("Select Tags")
                            .foregroundColor(.blue)
                    }
                }
            }
            .navigationBarTitle("Add New Word", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Close") {
                    dismiss()
                },
                trailing: Button(action: {
                    let newWord = Word(word: getTranslationsWithLanguageNames(wordTranslations: wordTranslations), percentage: 0, tags: selectedTags)
                    onAddWord(newWord)
                    
                    dictionary.wordCount += 1
                    dictionary.words.append(newWord)
                    DictionaryViewModel.shared.updateDictionaryWords(dictionary: dictionary, context: modelContext)
                    
                    dismiss()
                }) {
                    Text("Add")
                }
                .disabled(hasEmptyFields())
                .foregroundColor(hasEmptyFields() ? .gray : .blue)
            )
            .sheet(isPresented: $isTagSelectorPresented) {
                TagSelectorView(selectedTags: $selectedTags)
            }
        }
    }
    
    private func hasEmptyFields() -> Bool {
        for language in dictionary.languages {
            if wordTranslations[language]?.isEmpty ?? true {
                return true
            }
        }
        return false
    }

    
    func getTranslationsWithLanguageNames(wordTranslations: [String: String]) -> [String: String] {
        var translatedDictionary: [String: String] = [:]
        
        for (code, translation) in wordTranslations {
            let languageName = Language.getLanguageByCode(code: code).name
            translatedDictionary[languageName] = translation
        }
        
        return translatedDictionary
    }
    
}

struct AddWordView_Previews: PreviewProvider {
    static var previews: some View {
        AddWordView(
            dictionary: Dictionary(name: "Sample Dictionary", languages: ["EN", "RU", "DE"], wordCount: 100),
            onAddWord: { _ in }
        )
        .environmentObject(Settings())
        .environmentObject(LanguageManager())
        .modelContainer(PolyDictionaryApp.shared.GlobalContainer)
    }
}

