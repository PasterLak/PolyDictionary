import SwiftUI
import SwiftData
import Charts

struct WordStats: Identifiable {
    let id = UUID()
    let totalWords: Int
    let learnedWords: Int
}

struct StatsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var settings: Settings
    @Environment(\.modelContext) private var modelContext
    
    @Query private var dictionaries: [DictionaryModel]
    
    var totalWords: Int {
            dictionaries.reduce(0) { $0 + Int($1.wordCount) }
        }
    
    let statsData: [WordStats] = [
        WordStats(totalWords: 50, learnedWords: 20),
        WordStats(totalWords: 100, learnedWords: 60),
        WordStats(totalWords: 150, learnedWords: 110),
        WordStats(totalWords: 200, learnedWords: 180),
        WordStats(totalWords: 250, learnedWords: 230)
    ]
    
    var body: some View {
        NavigationView {
            
            List {
                
                Section(header: Text("General")) {
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    {
                        Image(systemName: "menucard.fill")
                            .frame(maxWidth: 25, maxHeight: 25)
                        Text("Total words:")
                        Spacer()
                        Text("\(totalWords)")
                    }
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    {
                        Image(systemName: "graduationcap.fill")
                            .frame(maxWidth: 25, maxHeight: 25)
                        Text("Learned words:")
                        Spacer()
                        Text("86")
                    }
                }
                
                Section(header: Text("Learned words:")) {
                    Chart(statsData) { dataPoint in
                        BarMark(
                            x: .value("Total Words", dataPoint.totalWords),
                            y: .value("Learned Words", dataPoint.learnedWords)
                            
                        )
                        .shadow(radius: 10)
                        .foregroundStyle(.green)
                        .cornerRadius(8)
                        .annotation(position: .top) {
                            Text("\(dataPoint.learnedWords)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                    }
                    
                    .frame(width: 320, height: 200)
                }
                
                Section(header: Text("Correct answers:")) {
                    Chart(statsData) { dataPoint in
                        LineMark(
                            x: .value("Total Words", dataPoint.totalWords),
                            y: .value("Learned Words", dataPoint.learnedWords)
                            
                        )
                        .foregroundStyle(.blue)
                        .shadow(radius: 10)
                        
                    }
                    .frame(width: 320, height: 200)
                    //.padding()
                    
                   
                }
                
            }
            .navigationBarTitle("Statistics", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Close") { dismiss() }
            )
            
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
            .environmentObject(Settings())
            .environmentObject(LanguageManager())
            .modelContainer(for: [DictionaryModel.self])
    }
}

