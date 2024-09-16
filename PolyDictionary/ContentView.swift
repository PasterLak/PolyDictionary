import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        TabView {
            NavigationView {
                DictionariesView()
            }
            .tabItem {
                Image(systemName: "character.book.closed")
                Text("Dictionaries")
            }
            
            NavigationView {
                SettingsView()
            }
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
        }
        .preferredColorScheme(settings.isDarkMode ? .dark : .light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Settings())  // Передаем объект в ContentView для предпросмотра
    }
}

