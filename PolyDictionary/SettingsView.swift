import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var settings: Settings
    
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
            
            
            Section(header: Text("Other settings:"), footer: Text("Not availible now")) {
                HStack {
                    Text("Theme")
                        .font(.headline)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    settings.resetSettings()
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
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(Settings())
    }
}
