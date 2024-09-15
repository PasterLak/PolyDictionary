import SwiftUI

@main
struct PolyDictionaryApp: App {
    @StateObject var settings = Settings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(settings.isDarkMode ? .dark : .light) 
        }
    }
}
