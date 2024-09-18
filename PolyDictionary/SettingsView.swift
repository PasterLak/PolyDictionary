import SwiftUI

import SwiftUI

struct RootView: View {
    @EnvironmentObject var languageManager: LanguageManager

    var body: some View {
        SettingsView()
            .id(languageManager.selectedLanguage)
    }
}


struct SettingsView: View {
    
    @EnvironmentObject var settings: Settings
    @EnvironmentObject var languageManager: LanguageManager
    
    @State private var showingLanguageSelection = false
    
    var body: some View {
        
        List {
            Section(header: Text("Basic:")) {
                Toggle(isOn: $settings.isDarkMode) {
                    Text("Dark Mode")
                        .font(.headline)
                }
                .toggleStyle(SwitchToggleStyle(tint: .green))
                
                Toggle(isOn: $settings.useFaceId) {
                    Text("Use Face ID")
                        .font(.headline)
                }
                .toggleStyle(SwitchToggleStyle(tint: .green))
            }
            
            Section(header: Text("Other settings:"), footer: Text("Not available now")) {
                HStack {
                    Text("Theme")
                        .font(.headline)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    //settings.resetSettings()
                }
            }
            
            Section(header: Text("Language")) {
                HStack {
                    Text("Language")
                        .font(.headline)
                    Spacer()
                    Text(languageManager.selectedLanguage == "en" ? "English" : "Russian")
                        .foregroundColor(.gray)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    showingLanguageSelection = true
                }
            }
            
            Section(footer: VStack(alignment: .center) {
                Text("\nPoly Dictionary")
                    .font(.headline)
                Text("App Version 0.1\n")
                    .font(.footnote)
                Text("Made with ❤️ in Schmalkalden")
                    .font(.subheadline)
                Text("Copyright(c) 2024 Vladislav")
                    .font(.footnote)
            }
            .frame(maxWidth: .infinity)) {
                EmptyView()
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("Settings", displayMode: .inline)
        .sheet(isPresented: $showingLanguageSelection) {
            LanguageSelectionView()
                .environmentObject(languageManager)
        }
    }
}

struct LanguageSelectionView: View {
    
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        List {
            Section(header: Text("Select Language")) {
                HStack {
                    Text("English")
                    Spacer()
                    if languageManager.selectedLanguage == "en" {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    languageManager.setLanguage("en")
                }
                
                HStack {
                    Text("Russian")
                    Spacer()
                    if languageManager.selectedLanguage == "ru" {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    languageManager.setLanguage("ru")
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("Language", displayMode: .inline)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(Settings())
            .environmentObject(LanguageManager())
    }
}

