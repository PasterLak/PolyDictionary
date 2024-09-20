import SwiftUI
import SwiftData

struct ContentView: View {
    
    //@Environment(\.modelContext) private var modelContext
    @EnvironmentObject var settings: Settings
    
    @State private var showOnboarding = false
    
   
    init()
    {
        //modelContext.
        //modelContext.container.
       // try? modelContext.save()
        return
        do {
           // try modelContext.delete(model: DictionaryModel.self)
            //try modelContext.delete(model: Word.self)
            //try modelContext.delete(model: Tag.self)
            print("Deleted")
        } catch {
            print("Failed to clear all  data.")
        }
    }
 

    var body: some View {
        ZStack {
            if showOnboarding {
                OnboardingView(showOnboarding: $showOnboarding)
                    .transition(.asymmetric(insertion: .slide, removal: .move(edge: .leading)))
                    .zIndex(1)
            } else {
                TabView {
                    NavigationView {
                        DictionariesView()
                    }
                    .tabItem {
                        Image(systemName: "character.book.closed")
                        Text("Dictionaries")
                    }
                    
                    NavigationView {
                        SettingsView()
                    }
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                }
                .preferredColorScheme(settings.isDarkMode ? .dark : .light)
                
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .slide))
                .zIndex(0)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: showOnboarding)
    }
}

#Preview("Main") {
    ContentView()
        .environmentObject(Settings())
        .environmentObject(LanguageManager())
        .modelContainer(for: [DictionaryModel.self, Tag.self, Word.self])
}
/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Settings())
            .environmentObject(LanguageManager())
            .modelContainer(for: [DictionaryModel.self, Tag.self, Word.self])
    }
}
*/

