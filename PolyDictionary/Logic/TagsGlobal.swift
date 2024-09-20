import SwiftData
import SwiftUI

public class TagsGlobal
{
    
    static let shared = TagsGlobal()

    @Environment(\.modelContext) private var modelContext
    
    @Query private var tags: [Tag]
    
    private init() {
        
        print("TagsGlobal Singleton initialized!")
    }
    
    func save(tag: Tag)
    {
        modelContext.insert(tag)
        saveContext(context: modelContext)
    }
    
    // MARK: - Helper Method to Save Context
    private func saveContext(context: ModelContext) {
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
