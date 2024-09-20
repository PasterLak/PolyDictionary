import SwiftUI
import SwiftData

@main
struct PolyDictionaryApp: App {
    
    public static let shared = PolyDictionaryApp()
    
    @StateObject var settings = Settings()
    @StateObject var languageManager = LanguageManager()
    
    public var GlobalContainer: ModelContainer {
        do {
            return try ModelContainer(for: Dictionary.self, Tag.self, Word.self)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }
   
    var body: some Scene {
        WindowGroup {

            ContentView()
                .environmentObject(settings)
                .environment(\.locale, .init(identifier: languageManager.selectedLanguage)) 
                .environmentObject(languageManager)
                .modelContainer(GlobalContainer)
                //.modelContainer(modelContainer)
          
        }
    }
}

