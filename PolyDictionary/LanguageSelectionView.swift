import SwiftUI


struct LanguageSelectionView: View {
    @Binding var selectedLanguages: [Language]
    @Environment(\.dismiss) var dismiss
    @StateObject var settings = Settings()
    @State private var searchText = ""

    var body: some View {
        Text("Select language:").padding().bold()
        List {
            
            ForEach(filteredLanguages) { language in
                Button(action: {
                    if !selectedLanguages.contains(language) {
                        selectedLanguages.append(language)
                    }
                    dismiss()
                }) {
                    HStack {
                        Text("\(language.flag) \(language.name)")
                        Spacer()
                        if selectedLanguages.contains(language) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
                .disabled(selectedLanguages.contains(language))
            }
        }
        .searchable(text: $searchText, prompt: "Search Languages")
        .navigationTitle("Select Language")
        .preferredColorScheme(settings.isDarkMode ? .dark : .light)
    }

    var filteredLanguages: [Language] {
        if searchText.isEmpty {
            return Language.allLanguages.filter { !selectedLanguages.contains($0) }
        } else {
            return Language.allLanguages.filter { $0.name.localizedCaseInsensitiveContains(searchText) && !selectedLanguages.contains($0) }
        }
    }
}
