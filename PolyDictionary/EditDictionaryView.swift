import SwiftUI

// Представление для редактирования словаря
struct EditDictionaryView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var settings = Settings()
    var dictionary: DictionaryItem
    @Binding var dictionaries: [DictionaryItem]
    @State private var name: String

    init(dictionary: DictionaryItem, dictionaries: Binding<[DictionaryItem]>) {
        self.dictionary = dictionary
        self._dictionaries = dictionaries
        self._name = State(initialValue: dictionary.name)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Dictionary Name")) {
                    TextField("Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            .navigationBarTitle("Edit Dictionary", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") { dismiss() },
                trailing: Button("Save") {
                    if let index = dictionaries.firstIndex(of: dictionary) {
                        dictionaries[index].name = name
                    }
                    dismiss()
                }
                .disabled(name.isEmpty)
            )
            .preferredColorScheme(settings.isDarkMode ? .dark : .light) // Исправлено для поддержки светлой темы
        }
    }
}

