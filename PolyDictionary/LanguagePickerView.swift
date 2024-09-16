import SwiftUI

struct LanguagePickerView: View {
    
    @Binding var selectedLanguages: [Language]
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var settings: Settings
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            Text("Select language")
                .bold().font(.headline).padding()
            HStack {
                Image(systemName: "magnifyingglass") 
                TextField("Search Languages", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
            }
            .padding()
            
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
            .listStyle(InsetGroupedListStyle())
        }
        .navigationTitle("Select Language")
        .preferredColorScheme(settings.isDarkMode ? .dark : .light)
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

