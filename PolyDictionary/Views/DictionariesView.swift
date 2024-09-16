import SwiftUI
import SwiftData

struct DictionariesView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = DictionaryViewModel()
    
    @Query private var dictionaries: [DictionaryModel]
    
    @State private var showAddDictionarySheet = false
    @State private var dictionaryToDelete: DictionaryModel?
    @State private var showDeleteConfirmation = false
    @State private var selectedDictionaryForEditing: DictionaryModel?
    @State private var showEditDictionarySheet = false
    
    var body: some View {
        List {
            ForEach(dictionaries) { dictionary in
                NavigationLink(destination: WordsView(dictionary: dictionary)) {
                    DictionaryRow(dictionary: dictionary)
                }
                .buttonStyle(PlainButtonStyle())
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        dictionaryToDelete = dictionary
                        showDeleteConfirmation = true
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button {
                        selectedDictionaryForEditing = dictionary
                        showEditDictionarySheet = true
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                    .tint(.blue)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("Dictionaries", displayMode: .large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) { // Добавляем кнопку в правом верхнем углу
                Button(action: {
                    showAddDictionarySheet = true
                }) {
                    Image(systemName: "plus") // Отображаем значок "+"
                }
            }
        }
        .sheet(isPresented: $showAddDictionarySheet) {
            AddDictionaryView() // Открываем представление для добавления словаря
        }
        .sheet(item: $selectedDictionaryForEditing) { dictionary in
            EditDictionaryView(dictionary: dictionary)
        }
        .alert("Delete Dictionary", isPresented: $showDeleteConfirmation, presenting: dictionaryToDelete) { dict in
            Button("Delete", role: .destructive) {
                if let dictionary = dictionaryToDelete {
                    viewModel.deleteDictionary(dictionary: dictionary, context: modelContext)
                }
            }
            Button("Cancel", role: .cancel) { }
        }
        .onAppear {
           
            if dictionaries.isEmpty {
                addDefaultDictionaries()
            }
        }
        
        
    }
    
    
    private func addDefaultDictionaries() {
        let defaultDictionaries = [
            DictionaryModel(name: "Learning russian", languages: ["EN", "RU"], wordCount: Int16(Int.random( in: 10...500))),
            DictionaryModel(name: "German-English Dictionary", languages: ["DE", "EN"], wordCount: Int16(Int.random( in: 10...500))),
            DictionaryModel(name: "Spanish-English Dictionary", languages: ["ES", "EN"], wordCount: Int16(Int.random( in: 10...500)))
        ]
        
        for dictionary in defaultDictionaries {
            modelContext.insert(dictionary)
        }
        
        try? modelContext.save() // Сохраняем изменения в базу данных
    }
    
}
