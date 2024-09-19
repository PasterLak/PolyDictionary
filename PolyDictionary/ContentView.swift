import SwiftUI

struct ContentView: View {
    @EnvironmentObject var settings: Settings
    
    @State private var showOnboarding = true

    var body: some View {
        ZStack {
            if showOnboarding {
                OnboardingView(showOnboarding: $showOnboarding)
                    .transition(.asymmetric(insertion: .slide, removal: .move(edge: .leading)))
                    .zIndex(1)
            } else {
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
                .modelContainer(for: [Dictionary.self])
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .slide))
                .zIndex(0)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: showOnboarding)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Settings())
            .environmentObject(LanguageManager())
            .modelContainer(for: [Dictionary.self])
    }
}
