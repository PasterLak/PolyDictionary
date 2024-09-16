import SwiftUI

struct DictionariesView: View {
    @StateObject var settings = Settings()
    
    @State private var dictionaries: [DictionaryItem] = [
        DictionaryItem(
            name: "My Dictionary",
            languages: [Language.getLanguageByCode(code: "RU"), Language.getLanguageByCode(code: "DE"),Language.getLanguageByCode(code: "EN")],
            wordCount: 258
        ),
        DictionaryItem(
            name: "Learning Spanish",
            languages: [Language.getLanguageByCode(code: "DE"),Language.getLanguageByCode(code: "ES")],
            wordCount: 63
        )
    ]
    @State private var showAddDictionarySheet = false
    @State private var dictionaryToDelete: DictionaryItem?
    @State private var showDeleteConfirmation = false
    @State private var selectedDictionaryForEditing: DictionaryItem?
    @State private var showEditDictionarySheet = false
    
    var body: some View {
        
        
        List {
            ForEach(dictionaries) { dictionary in
                NavigationLink(destination: WordsView(dictionary: dictionary)) {
                    DictionaryRow(dictionary: dictionary)
                }
                .buttonStyle(PlainButtonStyle())
                .listRowInsets(EdgeInsets())
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
            
            Button(action: {
                showAddDictionarySheet = true
            }) {
                AddDictionaryRow()
            }
            .buttonStyle(PlainButtonStyle())
            .listRowInsets(EdgeInsets())
        }
        .listStyle(PlainListStyle())
        .navigationBarTitle("Dictionaries", displayMode: .inline)
        .sheet(isPresented: $showAddDictionarySheet) {
            AddDictionaryView(dictionaries: $dictionaries)
                .environmentObject(settings)
        }
        .sheet(item: $selectedDictionaryForEditing) { dictionary in
            EditDictionaryView(dictionary: dictionary, dictionaries: $dictionaries)
                .environmentObject(settings)
        }
        .alert("Delete Dictionary", isPresented: $showDeleteConfirmation, presenting: dictionaryToDelete) { dict in
            Button("Delete", role: .destructive) {
                if let index = dictionaries.firstIndex(of: dict) {
                    dictionaries.remove(at: index)
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: { dict in
            Text("Are you sure you want to delete '\(dict.name)'?")
        }
        
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        DictionariesView()
    }
}
