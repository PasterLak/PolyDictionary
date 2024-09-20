import SwiftUI

struct AddWordView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss

    @State private var wordTranslations: [String: String]
    @State private var selectedTags: [String]
    @State private var isTagSelectorPresented = false

    @Bindable var dictionary: DictionaryModel
    var editingWord: Word?
    var onSave: (Word) -> Void

    init(dictionary: DictionaryModel, editingWord: Word? = nil, onSave: @escaping (Word) -> Void) {
        self._dictionary = Bindable(dictionary)
        self.editingWord = editingWord
        self.onSave = onSave

        _wordTranslations = State(initialValue: editingWord?.word ?? [:])
        _selectedTags = State(initialValue: editingWord?.tags ?? [])
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Translations")) {
                    ForEach(dictionary.languages, id: \.self) { languageCode in
                        let languageName = Language.getLanguageByCode(code: languageCode).name
                        TextField("Word in \(languageName)", text: Binding(
                            get: { wordTranslations[languageName] ?? "" },
                            set: { wordTranslations[languageName] = $0 }
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
            .navigationBarTitle(editingWord == nil ? "Add New Word" : "Edit Word", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Close") {
                    dismiss()
                },
                trailing: Button(action: saveWord) {
                    Text(editingWord == nil ? "Add" : "Save")
                }
                .disabled(hasEmptyFields())
                .foregroundColor(hasEmptyFields() ? .gray : .blue)
            )
            .sheet(isPresented: $isTagSelectorPresented) {
                TagSelectorView(selectedTags: $selectedTags)
            }
        }
    }

    private func saveWord() {
        let newWord = Word(
            word: wordTranslations,
            percentage: editingWord?.percentage ?? Int8.random(in: 0...100),
            tags: selectedTags
        )

        if let editingWord = editingWord {
            if let index = dictionary.words.firstIndex(where: { $0.id == editingWord.id }) {
                dictionary.words[index] = newWord
            }
        } else {
            dictionary.wordCount += 1
            dictionary.words.append(newWord)
        }

        DictionaryViewModel.shared.updateDictionaryWords(dictionary: dictionary, context: modelContext)
        onSave(newWord)
        dismiss()
    }

    private func hasEmptyFields() -> Bool {
        for languageCode in dictionary.languages {
            let languageName = Language.getLanguageByCode(code: languageCode).name
            if wordTranslations[languageName]?.isEmpty ?? true {
                return true
            }
        }
        return false
    }
}




struct AddWordView_Previews: PreviewProvider {
    static var previews: some View {
        AddWordView(
            dictionary: DictionaryModel(name: "Sample Dictionary", languages: ["EN", "RU", "DE"], wordCount: 100),
            onSave: { _ in }
        )
        .environmentObject(Settings())
        .environmentObject(LanguageManager())
        .modelContainer(for: [DictionaryModel.self, Tag.self, Word.self])
    }
}

