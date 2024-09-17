import SwiftUI

struct WordsView: View {
    
    var dictionary: DictionaryModel
    @State private var words: [WordModel] = []
    
    
    @State private var isPresented: Bool = false
    @State private var showingLearning = false
    
    @EnvironmentObject var settings: Settings
    
    @State private var test = ""
    
    var body: some View {
        VStack{
            HStack {
                Image(systemName: "magnifyingglass")
                    .padding(.leading)
                TextField("Search", text: $test)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    
                     //.cornerRadius(10)
                 // Color(UIColor.secondarySystemBackground)
            }
            
            .padding(.horizontal)
        ZStack {
            
            ScrollView {
                
                LazyVStack {
                    ForEach(Words.WordsDictionary) { wordItem in
                        WordRowView(wordItem: wordItem)
                            .padding(.horizontal)
                    }
                }
            }
            .onAppear {
                words = Words.WordsDictionary
            }
            .navigationBarTitle(dictionary.name, displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingLearning = true
                    }) {
                        Image(systemName: "lamp.desk")
                            .imageScale(.large)
                    }
                }
            }
            .background(settings.isDarkMode ? Color(UIColor.systemBackground) : Color(UIColor.secondarySystemBackground))
            .sheet(isPresented: $showingLearning) {
                LearningView()
            }
            
           
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        
                        isPresented = true
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .padding()
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 20)
                            .opacity(0.85)
                        
                    }
                    .padding()
                    .sheet(isPresented: $isPresented) {
                        
                        AddWordView(dictionary: dictionary)
                    }
                }
            }
        }
        }.background(settings.isDarkMode ? Color(UIColor.systemBackground) : Color(UIColor.secondarySystemBackground))
    }
}


struct WordsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WordsView(dictionary: DictionaryModel(
                name: "Sample Dictionary",
                languages: ["RU", "DE"],
                wordCount: 100
            ))
            .environmentObject(Settings())
            .modelContainer(for: DictionaryModel.self) 
        }
    }
}


