import SwiftUI

enum TagColor: String, CaseIterable, Codable {
    case yellow
    case blue
    case green
    case red
    case purple
    
    
    var color: Color {
        switch self {
        case .yellow: return .yellow
        case .blue: return .blue
        case .green: return .green
        case .red: return .red
        case .purple: return .purple
        }
    }
    
    static func allColors() -> [Color] {
        return TagColor.allCases.map { $0.color }
    }
    
    static func fromColor(_ color: Color) -> TagColor {
        switch color {
        case .yellow: return .yellow
        case .blue: return .blue
        case .green: return .green
        case .red: return .red
        case .purple: return .purple
        default: return .yellow
        }
    }
}

