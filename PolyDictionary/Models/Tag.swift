import SwiftUI
import SwiftData

@Model
final class Tag: Identifiable
{
    
    @Attribute(.unique) var id: String = UUID().uuidString
    var name: String
    private var colorEnum: TagColor
    public var isGlobal: Bool
    public var dateCreated: Date
    public var isPinned: Bool
    
    
    public init(id: String = UUID().uuidString, name: String, color: TagColor, isGlobal: Bool) {
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


