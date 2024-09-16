import Foundation
import SwiftUI

class LanguageManager: ObservableObject {
    @Published var selectedLanguage: String = Locale.current.language.languageCode?.identifier ?? "en" {
        didSet {
            setLanguage(selectedLanguage)
        }
    }

    func setLanguage(_ languageCode: String) {
        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        Bundle.setLanguage(languageCode)
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
