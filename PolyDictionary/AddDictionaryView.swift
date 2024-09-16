import SwiftUI
import SwiftData

struct AddDictionaryView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var settings: Settings
    @Environment(\.modelContext) private var modelContext // Используем контекст для сохранения
    
    @State private var name: String = ""
    @State private var selectedLanguages: [Language] = []
    @State private var showLanguageSelection = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Dictionary Name")) {
                    TextField("Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Section(header: Text("Languages")) {
                    ForEach(selectedLanguages) { language in
                        Text("\(language.flag) \(language.name)")
                    }
                    .onDelete(perform: deleteLanguage)
                    .onMove(perform: moveLanguage)
                    
                    if selectedLanguages.count < 5 {
                        Button(action: {
                            showLanguageSelection = true
                        }) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.blue)
                                Text("Add Language")
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Add Dictionary", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") { dismiss() },
                trailing: Button("Add") {
                    addDictionary()
                }
                .disabled(name.isEmpty || selectedLanguages.count < 2)
            )
            .sheet(isPresented: $showLanguageSelection) {
                LanguagePickerView(selectedLanguages: $selectedLanguages)
                    .environmentObject(settings)
            }
        }
    }
    
    private func addDictionary() {
        let selectedLanguageCodes = selectedLanguages.map { $0.code }
        let newDictionary = DictionaryModel(
            name: name,
            languages: selectedLanguageCodes,
            wordCount: 0
        )
        
        // Сохраняем новый словарь через modelContext
        modelContext.insert(newDictionary)
        try? modelContext.save() // Сохраняем изменения в базу данных
        
        dismiss() // Закрываем представление
    }
    
    private func deleteLanguage(at offsets: IndexSet) {
        selectedLanguages.remove(atOffsets: offsets)
    }
    
    private func moveLanguage(from source: IndexSet, to destination: Int) {
        selectedLanguages.move(fromOffsets: source, toOffset: destination)
    }
}

