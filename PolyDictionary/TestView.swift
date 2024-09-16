import SwiftUI

struct TestView: View {
    @StateObject var languageManager = LanguageManager()
    @State private var reloadFlag = false

    var body: some View {
        VStack {
            Text("hello")
            Text("welcome")
            
            Picker("Select Language", selection: $languageManager.selectedLanguage) {
                Text("English").tag("en")
                Text("Russian").tag("ru")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
        .environment(\.locale, .init(identifier: languageManager.selectedLanguage)) //
        .id(reloadFlag)
        .onChange(of: languageManager.selectedLanguage) { _ in
            reloadFlag.toggle()
        }
    }
    
}

#Preview {
    TestView()
}
