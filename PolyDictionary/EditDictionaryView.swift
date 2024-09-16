import SwiftUI
import SwiftData

struct EditDictionaryView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext // Для сохранения изменений
    var dictionary: DictionaryModel
    @State private var name: String

    init(dictionary: DictionaryModel) {
        self.dictionary = dictionary
        self._name = State(initialValue: dictionary.name) // Инициализация имени словаря
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
                    saveChanges()
                    dismiss()
                }
                .disabled(name.isEmpty) // Деактивируем кнопку, если имя пустое
            )
        }
    }
    
    // Метод для сохранения изменений
    private func saveChanges() {
        dictionary.name = name
        try? modelContext.save() // Сохраняем изменения в базу данных
    }
}

