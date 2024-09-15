import SwiftUI


import SwiftUI

struct ContentView: View {
    @StateObject var settings = Settings()
    
    var body: some View {
        
 
            
            TabView {
                NavigationView {
                    MainView()
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
            .environmentObject(settings)
          
           .preferredColorScheme(settings.isDarkMode ? .dark : .light)
        
                
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

