import SwiftUI

// Представление для строки "Добавить новый словарь"
struct AddDictionaryRow: View {
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(UIColor.secondarySystemBackground))
            HStack {
                Text("Add New Dictionary")
                    .font(.headline)
                Spacer()
                Image(systemName: "plus.circle.fill")
                    .font(.title)
                    .foregroundColor(.blue)
            }
            .padding()
        }
        .frame(height: 80)
    }
}

