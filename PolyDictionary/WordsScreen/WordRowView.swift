import SwiftUI

struct WordRowView: View {
    
    let wordModel: Word
    var dictionary: Dictionary
    
    @Environment(\.modelContext) private var modelContext
    
    @EnvironmentObject var settings: Settings
    @State private var showDeleteConfirmation = false
    
    var body: some View {
        
        
        Button(action: {
          
           // AddWordView(dictionary: dictionary, onAddWord: { _ in }).setEditData(word: wordModel)
            //print("Word tapped: \(wordModel.word)")
        }) {
            
            
            HStack{
                VStack(alignment: .leading) {
                    Text(getFirstWordFromDictionary())
                        .font(.headline)
                    
                    Text(wordModel.getTranslationsWithFlags(for: dictionary.languages))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text(wordModel.getTagsAsString())
                        .font(.caption)
                        .foregroundColor(settings.isDarkMode ? .yellow : Color(red: 0.95, green: 0.6, blue: 0.1))
                }
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(colorForPercentage(wordModel.percentage), lineWidth: wordModel.percentage < 100 ? 2 : 0)
                        .frame(width: 50, height: 50)
                    if wordModel.percentage < 100 {
                        Text("\(wordModel.percentage)%")
                            .font(.headline)
                    } else {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.green)
                    }
                }
            } // HStack
            .foregroundColor(settings.isDarkMode ? .white : .black)
            .preferredColorScheme(settings.isDarkMode ? .dark : .light)
            
        }
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                // dictionaryToDelete = dictionary
                // showDeleteConfirmation = true
                dictionary.wordCount -= 1
                modelContext.delete(wordModel)
                try? modelContext.save()
                
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
        .swipeActions(edge: .leading) {
            Button {
                // selectedDictionaryForEditing = dictionary
                // showEditDictionarySheet = true
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            .tint(.blue)
        }

    }
   
    
    func getFirstWordFromDictionary() -> String {
        let languageName = Language.getLanguageByCode(code: dictionary.languages[0]).name
        return wordModel.word[languageName] ?? wordModel.word.first?.value ?? "Error"
    }
    
    func colorForPercentage(_ percentage: Int8) -> Color {
        switch percentage {
        case ..<20:
            return Color.red
        case 20...40:
            return Color.orange
        case 40...60:
            return Color.yellow
        case 60...80:
            return Color.green
        case 80...95:
            return Color.blue
        default:
            return Color.purple
        }
    }
    
    func deleteWord() {
        print("Deleting word: \(wordModel.word)")
        // Реализовать удаление из вашего массива слов
    }
}

#Preview {
    WordRowView(
        wordModel: Word(word: ["English": "Apple", "German": "Apfel", "Russian": "Яблоко"], percentage: Int8.random(in: 1...100), tags: ["#tag"]),
        dictionary: Dictionary(name: "Sample Dictionary", languages: ["EN", "RU", "DE"], wordCount: 100)
    )
    .environmentObject(Settings())
    .modelContainer(PolyDictionaryApp.shared.GlobalContainer)
}
