import SwiftUI

struct AddWordView: View {
    
    var dictionary: DictionaryModel
    
    @State private var wordTranslations: [String: String] = [:]
    @State private var selectedTags: [String] = []
    @State private var isTagSelectorPresented = false
    @Environment(\.dismiss) var dismiss 
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Translations")) {
                    ForEach(dictionary.languages, id: \.self) { language in
                        TextField("Word in \(language)", text: Binding(
                            get: { wordTranslations[language] ?? "" },
                            set: { wordTranslations[language] = $0 }
                        ))
                        .autocapitalization(.none)
                    }
                }
                
                // Выбор тегов
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
                    dismiss() // Закрываем окно
                },
                trailing: Button("Add") {
                    // Логика для добавления слова (сохранение данных)
                    dismiss()
                }
            )
            .sheet(isPresented: $isTagSelectorPresented) {
                TagSelectorView(selectedTags: $selectedTags)
            }
        }
       // .presentationDetents([.medium, .large]) // Отображаем окно снизу вверх
    }
}



struct AddWordView_Previews: PreviewProvider {
    static var previews: some View {
        AddWordView(dictionary: DictionaryModel(name: "Sample Dictionary", languages: ["EN", "RU", "DE"], wordCount: 100))
    }
}

