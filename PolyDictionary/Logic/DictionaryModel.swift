
import SwiftUI

import Foundation
import SwiftData

@Model
final class DictionaryModel: Identifiable, Equatable {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    var name: String
    var languages: [String] // EN
    var wordCount: Int16

    
    init(id: String = UUID().uuidString, name: String, languages: [String], wordCount: Int16) {
        self.id = id
        self.name = name
        self.languages = languages
        self.wordCount = wordCount
    }
    
//    static var sampleData: [ToDo] {
//        [
//            ToDo(name: "Create a sample project on swiftdata"),
//            ToDo(name: "Record the initial setup for Chris to use", isCompleted: true)
//        ]
//    }
}




/*
 
 import Foundation
 import SwiftData

 @Model
 final class DictionaryModel: Identifiable, Equatable {
     
     @Attribute(.unique) var id: String = UUID().uuidString
     var name: String
     var languages: [String] // EN
     var wordCount: Int16

     
     init(id: String = UUID().uuidString, name: String, languages: [String], wordCount: Int16) {
         self.id = id
         self.name = name
         self.languages = languages
         self.wordCount = wordCount
     }
     
 //    static var sampleData: [ToDo] {
 //        [
 //            ToDo(name: "Create a sample project on swiftdata"),
 //            ToDo(name: "Record the initial setup for Chris to use", isCompleted: true)
 //        ]
 //    }
 }


 
 */

