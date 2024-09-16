import SwiftUI
import CoreData

@main
struct PolyDictionaryApp: App {
    @StateObject var settings = Settings()
    @StateObject var languageManager = LanguageManager()
   
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settings)
                .environment(\.locale, .init(identifier: languageManager.selectedLanguage)) 
                .environmentObject(languageManager)
 
        }
    }
}


