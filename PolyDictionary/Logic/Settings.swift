import SwiftUI

class Settings: ObservableObject {
    @Published var isDarkMode: Bool {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
        }
    }
    
    @Published var useFaceId: Bool {
        didSet {
            UserDefaults.standard.set(useFaceId, forKey: "useFaceId")
        }
    }

    init() {
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        self.useFaceId = UserDefaults.standard.bool(forKey: "useFaceId")
    }
}
