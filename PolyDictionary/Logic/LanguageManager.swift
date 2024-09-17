import Foundation
import SwiftUI

class LanguageManager: ObservableObject {
    @Published var selectedLanguage: String = Locale.current.language.languageCode?.identifier ?? "en" {
        didSet {
            setLanguage(selectedLanguage)
        }
    }
    
    public func current() -> String{
        return selectedLanguage
    }

    func setLanguage(_ languageCode: String) {
        // Сохранение выбранного языка в UserDefaults
        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        // Вызываем обновление интерфейса через изменение id
        objectWillChange.send()
        
        // Сообщение о необходимости перезагрузки
        print("Language changed to \(languageCode). A restart might be required.")
    }
}



extension Bundle {
    private static var bundleKey: UInt8 = 0

    static func setLanguage(_ language: String) {
        object_setClass(Bundle.main, PrivateBundle.self)
        objc_setAssociatedObject(Bundle.main, &bundleKey, Bundle(path: Bundle.main.path(forResource: language, ofType: "lproj") ?? "") ?? Bundle.main, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    private class PrivateBundle: Bundle {
        override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
            return (objc_getAssociatedObject(Bundle.main, &Bundle.PrivateBundle.bundleKey) as? Bundle)?.localizedString(forKey: key, value: value, table: tableName) ?? super.localizedString(forKey: key, value: value, table: tableName)
        }
    }
}
