import SwiftUI

struct WordRowView: View {
    
    let wordModel: Word
    var dictionary: Dictionary
    @EnvironmentObject var settings: Settings
    @State private var showDeleteConfirmation = false

    var body: some View {
        HStack {
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
        }
        .padding(.vertical, 8)
        .onTapGesture {
            print("Word tapped: \(wordModel.word)")
        }
        .swipeActions(edge: .leading) {
            Button(action: {
                print("Edit \(wordModel.word)")
            }) {
                Label("Edit", systemImage: "pencil")
            }
            .tint(.blue)
        }
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                showDeleteConfirmation = true
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
        .confirmationDialog("Are you sure you want to delete this word?", isPresented: $showDeleteConfirmation, titleVisibility: .visible) {
            Button("Delete", role: .destructive) {
                deleteWord()
            }
            Button("Cancel", role: .cancel) { }
        }
        .preferredColorScheme(settings.isDarkMode ? .dark : .light)
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
    .modelContainer(for: [Dictionary.self])
}
