import SwiftUI

// Представление для добавления нового словаря
struct AddDictionaryView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var settings = Settings()
    @Binding var dictionaries: [DictionaryItem]
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
                    let newDictionary = DictionaryItem(
                        name: name,
                        languages: selectedLanguages,
                        wordCount: 0
                    )
                    dictionaries.append(newDictionary)
                    dismiss()
                }
                .disabled(name.isEmpty || selectedLanguages.count < 2)
            )
            .environment(\.editMode, .constant(.active))
            .sheet(isPresented: $showLanguageSelection) {
                LanguageSelectionView(selectedLanguages: $selectedLanguages)
                    .environmentObject(settings)
            }
            .preferredColorScheme(settings.isDarkMode ? .dark : .light) 
        }
    }

    func deleteLanguage(at offsets: IndexSet) {
        selectedLanguages.remove(atOffsets: offsets)
    }

    func moveLanguage(from source: IndexSet, to destination: Int) {
        selectedLanguages.move(fromOffsets: source, toOffset: destination)
    }
}

