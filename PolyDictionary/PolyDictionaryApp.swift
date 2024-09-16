import SwiftUI
import CoreData

@main
struct PolyDictionaryApp: App {
    @StateObject var settings = Settings()
    @StateObject var languageManager = LanguageManager()
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settings)
                .environment(\.locale, .init(identifier: languageManager.selectedLanguage)) 
                .environmentObject(languageManager)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "DictionaryItemEntity")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error loading Core Data stack: \(error)")
            }
        }
    }
}


