import Foundation
import SwiftUI

// Модель элемента словаря
struct DictionaryItem: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var languages: [Language]
    var wordCount: Int
}
