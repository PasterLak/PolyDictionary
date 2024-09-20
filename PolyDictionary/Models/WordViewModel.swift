import SwiftData
import SwiftUI

class WordViewModel: ObservableObject {

    // MARK: - Save Method
    func saveWord(word: Word, context: ModelContext) {
        context.insert(word)
        saveContext(context: context)
    }

    // MARK: - Update Method
    func updateDictionary(word: Word, name: String, languages: [String], wordCount: Int16, context: ModelContext) {
        //dictionary.name = name
       // dictionary.languages = languages
       // dictionary.wordCount = wordCount
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

