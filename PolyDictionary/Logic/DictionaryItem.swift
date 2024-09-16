import Foundation
import SwiftUI

struct DictionaryItem: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var languages: [String] // EN
    var wordCount: Int
}




