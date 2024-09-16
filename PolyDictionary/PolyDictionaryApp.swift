import SwiftUI
import SwiftData

@main
struct PolyDictionaryApp: App {
    @StateObject var settings = Settings()
    @StateObject var languageManager = LanguageManager()
    
    var modelContainer: ModelContainer {
            do {
                return try ModelContainer(for: DictionaryModel.self)
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
                .modelContainer(for: [DictionaryModel.self])
                .modelContainer(modelContainer)
        }
    }
}


