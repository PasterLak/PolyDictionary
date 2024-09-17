import SwiftUI

struct DictionaryRow: View {
    
    var dictionary: DictionaryModel
    
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 8)
                //.fill(Color.gray)
                
                .fill(settings.isDarkMode ? Color(UIColor.secondarySystemBackground) : Color(UIColor.systemBackground))
                //.shadow(radius: 1)
            VStack(alignment: .leading) {
                Text(dictionary.name)
                    .font(.headline)
                Spacer()
                
                HStack {
                    // Map language codes to Language objects and display
                    ForEach(dictionary.languages, id: \.self) { code in
                        let language = Language.getLanguageByCode(code: code)
                        HStack(spacing: 2) {
                            Text(language.flag)
                            Text(language.code)
                                .font(.caption)
                        }
                    }
                    Spacer()
                    Text("\(dictionary.wordCount) words")
                        .font(.subheadline)
                }
            }
            .padding()
        }
        .frame(height: 90)
        
    }
}


