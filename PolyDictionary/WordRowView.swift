import SwiftUI

struct WordRowView: View {
    
    let wordItem: WordModel
    
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                
                Text(wordItem.word["English"] ?? "Error")
                    .font(.headline)
                

                Text(wordItem.getTranslationsWithFlags())
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
               
                Text(wordItem.getTagsAsString())
                    .font(.caption)
                    .foregroundColor(.yellow)
               
            }
            Spacer()
            
            ZStack {
                Circle()
                    .stroke(colorForPercentage(wordItem.percentage), lineWidth: 2)
                    .frame(width: 50, height: 50)
                if wordItem.percentage < 100 {
                    Text("\(wordItem.percentage)%")
                        .font(.headline)
                } else {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.purple)
                }
            }
        }
        .padding(.vertical, 8)
        .onTapGesture {
            // Обрабатываем нажатие на строку
            print("Word tapped: \(wordItem.word)")
        }
        .swipeActions(edge: .leading) {
            Button(action: {
                // Действие редактирования
                print("Edit \(wordItem.word)")
            }) {
                Label("Edit", systemImage: "pencil")
            }
            .tint(.blue) // Цвет кнопки редактирования
        }
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                // Действие удаления
                print("Delete \(wordItem.word)")
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
        .preferredColorScheme(settings.isDarkMode ? .dark : .light)
    }
    
    func colorForPercentage(_ percentage: Int) -> Color {
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
}

#Preview {
    WordRowView(
        wordItem: WordModel(word: ["English": "Apple", "German": "Apfel", "Russian": "Яблоко"], percentage: Int.random(in: 1...100), tags: ["#tag"])
    )
        .environmentObject(Settings())
}

