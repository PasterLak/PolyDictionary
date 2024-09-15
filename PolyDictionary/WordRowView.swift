import SwiftUI


struct WordRowView: View {
    
    let wordItem: WordItem
    
    @StateObject var settings = Settings()
    
    var body: some View {
        HStack {
            
            /*Image(systemName: randomIcon())
             .resizable()
             .frame(width: 55, height: 40)
             .padding(.trailing, 8)*/
            
            // Текст в центре
            VStack(alignment: .leading) {
                
                Text(wordItem.word)
                    .font(.headline)
                
                
                
                Text(wordItem.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("#tag #food")
                    .font(.caption).foregroundColor(.yellow)
                
            }
            Spacer()
            
            ZStack {
                Circle()
                    .stroke(colorForPercentage(wordItem.percentage), lineWidth: 2)
                    .frame(width: 50, height: 50)
                if wordItem.percentage < 100
                {
                    Text("\(wordItem.percentage)%")
                        .font(.headline)
                }
                else
                {
                    Image(systemName: "checkmark.circle.fill")
                    
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.purple)
                    //.padding(.trailing, 8)
                    
                }
            }
        }
        .padding(.vertical, 8)
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
    
    func randomIcon() -> String {
        let icons = ["globe", "envelope.fill", "mail", "creditcard"]
        return icons.randomElement() ?? "questionmark"
    }
}



#Preview {
    WordRowView(wordItem: Words.WordsDictionary[0])
}
