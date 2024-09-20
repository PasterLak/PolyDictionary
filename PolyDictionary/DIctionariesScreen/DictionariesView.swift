import SwiftUI
import SwiftData

struct DictionariesView: View {
    @Environment(\.modelContext) private var modelContext
   
    @EnvironmentObject var settings: Settings
    
    @Query private var dictionaries: [Dictionary]
    
    @State private var showAddDictionarySheet = false
    @State private var showStatsSheet = false
    @State private var dictionaryToDelete: Dictionary?
    @State private var showDeleteConfirmation = false
    @State private var selectedDictionaryForEditing: Dictionary?
    @State private var showEditDictionarySheet = false
    
    var body: some View {
        List {
            ForEach(dictionaries.sorted(by: { $0.wordCount > $1.wordCount })) { dictionary in
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
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showAddDictionarySheet = true
                }) {
                    Image(systemName: "plus")
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    showStatsSheet = true
                }) {
                    Image(systemName: "chart.bar.xaxis")
                }
            }
        }
        .sheet(isPresented: $showAddDictionarySheet) {
            AddDictionaryView()
        }
        .sheet(isPresented: $showStatsSheet) {
            StatsView()
        }
        .sheet(item: $selectedDictionaryForEditing) { dictionary in
            EditDictionaryView(dictionary: dictionary)
        }
        .alert("Delete Dictionary", isPresented: $showDeleteConfirmation, presenting: dictionaryToDelete) { dict in
            Button("Delete", role: .destructive) {
                if let dictionary = dictionaryToDelete {
                    DictionaryViewModel.shared.deleteDictionary(dictionary: dictionary, context: modelContext)
                }
            }
            Button("Cancel", role: .cancel) { }
            
        }
        .preferredColorScheme(settings.isDarkMode ? .dark : .light)
        .onAppear {
            
           for dic in dictionaries
            {
               dic.wordCount = Int16(dic.words.count)
           }
            
            if dictionaries.isEmpty {
                //addDefaultDictionaries()
            }
        }
        
        
    }
    
    
    private func addDefaultDictionaries() {
        let defaultDictionaries = [
            Dictionary(name: "Words to learn", languages: ["EN", "DE", "RU"], wordCount: Int16(Int.random( in: 10...800))),
            //DictionaryModel(name: "German-English Dictionary", languages: ["DE", "EN"], wordCount: Int16(Int.random( in: 10...500))),
           // DictionaryModel(name: "Latin languages", languages: ["ES", "IT", "PT"], wordCount: Int16(Int.random( in: 10...500)))
        ]
        
        for dictionary in defaultDictionaries {
            modelContext.insert(dictionary)
        }
        
        try? modelContext.save()
    }
    
}
