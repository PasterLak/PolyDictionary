import SwiftUI

struct AddWordView: View {
    
    var dictionary: DictionaryModel
    @State private var wordTranslations: [String: String] = [:]
    @State private var selectedTags: [String] = []
    @State private var isTagSelectorPresented = false
    @Environment(\.dismiss) var dismiss

    var onAddWord: (WordModel) -> Void

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
                    let newWord = WordModel(word: wordTranslations, percentage: 0, tags: selectedTags)
                    onAddWord(newWord)
                    dismiss()
                }) {
                    Text("Add")
                }
                .disabled(areAllFieldsEmpty()) // Деактивация кнопки, если поля пустые
                .foregroundColor(areAllFieldsEmpty() ? .gray : .blue)
            )
            .sheet(isPresented: $isTagSelectorPresented) {
                TagSelectorView(selectedTags: $selectedTags)
            }
        }
    }

    // Проверяем, что все поля перевода пустые
    private func areAllFieldsEmpty() -> Bool {
        for (_, value) in wordTranslations {
            if !value.isEmpty {
                return false
            }
        }
        return true
    }
}

struct AddWordView_Previews: PreviewProvider {
    static var previews: some View {
        AddWordView(
            dictionary: DictionaryModel(name: "Sample Dictionary", languages: ["EN", "RU", "DE"], wordCount: 100),
            onAddWord: { _ in }
        )
        .environmentObject(Settings())
        .environmentObject(LanguageManager())
        .modelContainer(for: [DictionaryModel.self])
    }
}

