import Foundation
import SwiftUI

struct DictionaryItem: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var languages: [Language]
    var wordCount: Int
}
