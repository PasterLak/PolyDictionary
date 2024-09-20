import SwiftData
import SwiftUI

class DictionaryViewModel: ObservableObject {

    static let shared = DictionaryViewModel()
    
    private init() {
           
            //print("DictionaryViewModel Singleton initialized!")
        }
    
    // MARK: - Save Method
    func saveDictionary(dictionary: DictionaryModel, context: ModelContext) {
        context.insert(dictionary)
        saveContext(context: context)
    }

    // MARK: - Update Method
    func updateDictionary(dictionary: DictionaryModel, name: String, languages: [String], wordCount: Int16, context: ModelContext) {
        dictionary.name = name
        dictionary.languages = languages
        dictionary.wordCount = wordCount
        saveContext(context: context)
    }
    func updateDictionaryWords(dictionary: DictionaryModel,  context: ModelContext) {
       
        saveContext(context: context)
    }

    // MARK: - Delete Method
    func deleteDictionary(dictionary: DictionaryModel, context: ModelContext) {
        context.delete(dictionary)
        saveContext(context: context)
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
