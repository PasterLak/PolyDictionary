import SwiftUI

struct LanguagePickerView: View {
    
    @Binding var selectedLanguages: [Language]
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var settings: Settings
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            Text("Select language")
                .bold()
                .font(.headline)
                .padding()
            
            searchBar
            
            List {
                if searchText.isEmpty {
                    Section(header: Text("Top 5 Popular Languages")) {
                        languageSection(languages: topPopularLanguages)
                    }
                    Section(header: Text("Other languages")) {
                        languageSection(languages: otherLanguages)
                    }
                } else {
                    languageSection(languages: filteredLanguages)
                }
            }
            .navigationBarItems(
                leading: Button("Close") { dismiss() }
            )
            .listStyle(InsetGroupedListStyle())
        }
        
        .preferredColorScheme(settings.isDarkMode ? .dark : .light)
    }
    
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading)
            TextField("Search Languages", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
        }
        .padding(.horizontal)
    }
    
  
    private func languageSection(languages: [Language]) -> some View {
        ForEach(languages) { language in
            languageButton(for: language)
        }
    }
    
    
    private func languageButton(for language: Language) -> some View {
        Button(action: {
            selectLanguage(language)
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
    
  
    private func selectLanguage(_ language: Language) {
        if !selectedLanguages.contains(language) {
            selectedLanguages.append(language)
        }
        dismiss()
    }
    

    var filteredLanguages: [Language] {
        if searchText.isEmpty {
            return Language.allLanguages.filter { !selectedLanguages.contains($0) }
        } else {
            return Language.allLanguages.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) && !selectedLanguages.contains($0)
            }
        }
    }
    
    
    var topPopularLanguages: [Language] {
        return Array(filteredLanguages.sorted(by: { $0.rating > $1.rating }).prefix(5))
    }
    
    
    var otherLanguages: [Language] {
        let topLanguages = Set(topPopularLanguages)
        return filteredLanguages
            .filter { !topLanguages.contains($0) }
            .sorted(by: { $0.name < $1.name })
    }
}

struct LanguagePickerView_Previews: PreviewProvider {
    @State static var selectedLanguages: [Language] = []
    
    static var previews: some View {
        NavigationView {
            LanguagePickerView(selectedLanguages: $selectedLanguages)
                .environmentObject(Settings())
        }
    }
}

