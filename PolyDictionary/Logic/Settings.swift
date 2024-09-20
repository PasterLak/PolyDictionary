import SwiftUI

public class Settings: ObservableObject {
    @Published var isDarkMode: Bool {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
            UserDefaults.standard.synchronize()
        }
    }
    
    @Published var useFaceId: Bool {
        didSet {
            UserDefaults.standard.set(useFaceId, forKey: "useFaceId")
            UserDefaults.standard.synchronize()
        }
    }
    
    init() {
       
        self.isDarkMode = UserDefaults.standard.object(forKey: "isDarkMode") as? Bool ?? false
        self.useFaceId = UserDefaults.standard.object(forKey: "useFaceId") as? Bool ?? false
    }
   
   public func resetSettings() {
        isDarkMode = false
        useFaceId = false
    }
}

