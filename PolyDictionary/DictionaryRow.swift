import SwiftUI



struct DictionaryRow: View {
    var dictionary: DictionaryItem

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(UIColor.secondarySystemBackground))
            VStack(alignment: .leading) {
                Text(dictionary.name)
                    .font(.headline)
                Spacer()
                
                HStack {
                    ForEach(dictionary.languages) { language in
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
        .frame(height: 80)
    }
}

