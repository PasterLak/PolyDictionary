//
//  SettingsView.swift
//  PolyDictionary
//
//  Created by Vladislav Beidinger on 14.09.24.
//

import SwiftUI

// If `Settings` is in another file, make sure it's imported
// import YourModuleName

struct SettingsView: View {
    @EnvironmentObject var settings: Settings

    var body: some View {
        
        
        VStack
        {
            List {
                // Section with toggle switches
                Section {
                    // Toggle switch to change the app theme
                    Toggle(isOn: $settings.isDarkMode) {
                        Text("Dark Mode")
                            .font(.headline)
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .green))
                    
                    // Toggle switch to use Face ID
                    Toggle(isOn: $settings.useFaceId) {
                        Text("Use Face ID")
                            .font(.headline)
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .green))
                }
                
                // Section with a navigation-like row
                Section(header: Text("Other settings:"), footer: Text("Not availible now")) {
                    HStack {
                        Text("Theme")
                            .font(.headline)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .contentShape(Rectangle()) // Makes the entire row tappable
                    .onTapGesture {
                        // Does nothing
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Settings", displayMode: .inline)
            
            
            Text("Version 0.1").foregroundColor(settings.isDarkMode ? .white : .black)
                .font(.subheadline)
            Text("Made with ❤️ in Schmalkalden").foregroundColor(settings.isDarkMode ? .white : .black)
                .font(.subheadline)
                
            Spacer()
        }
        
        
    }
    
   
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(Settings())
    }
}
