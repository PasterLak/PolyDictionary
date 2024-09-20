import SwiftUI
import SwiftData

@Model
final class Tag: Identifiable
{
   // let id = UUID()
    @Attribute(.unique) let name: String
    private var colorEnum: TagColor
    public var isGlobal: Bool
    public var dateCreated: Date
    public var isPinned: Bool
    
    
    public init(name: String, color: TagColor, isGlobal: Bool) {
        self.name = name
        self.colorEnum = color
        self.isGlobal = isGlobal
        self.dateCreated = Date.now
        self.isPinned = false
    }
    
    public var color: Color {
            return colorEnum.color
        }
    
    

}


