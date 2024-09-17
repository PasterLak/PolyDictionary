import SwiftUI

struct TrainingView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showingSettings = false
    
    @EnvironmentObject var settings: Settings
    
    let trainingTypes: [TrainingType] = [
        TrainingType(name: "Flashcards", color: .blue, icon: "menucard.fill"),
        TrainingType(name: "Writing", color: .green, icon: "pencil"),
        TrainingType(name: "Listening", color: .purple, icon: "ear.fill"),
        TrainingType(name: "Speaking", color: .orange, icon: "bubble.fill"),
        TrainingType(name: "Matching", color: .red, icon: "hand.thumbsup.fill"),
        TrainingType(name: "Multiple Choice", color: .pink, icon: "hand.point.up.left.and.text.fill")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                    ForEach(trainingTypes) { training in
                        TrainingTileView(training: training)
                            .shadow(radius: 5)
                    }
                }
                .padding(.horizontal)
                .padding(.top)

                
                ZStack
                {
                    RoundedRectangle(cornerRadius: 15)
                        //.background(LinearGradient(gradient: Gradient(colors: [Color(red: 0.97, green: 0.92, blue: 0.95), Color(red: 0.8, green: 0.82, blue: 0.85)]), startPoint: .leading, endPoint: .trailing))
                       // .foregroundColor(.clear)
                        //.cornerRadius(10)
                    // Color(UIColor.secondarySystemBackground)
                        .fill(settings.isDarkMode ? Color(red: 0.38, green: 0.3, blue: 0.45) : Color(red: 0.97, green: 0.92, blue: 0.95))
                        .frame(height: 300)
                        .padding(.horizontal)
                       
                        .shadow(radius: 4)
                    
                    VStack (){
                        
                        Text("Description").padding().font(.headline)
                        Spacer()
                    }
                    
                }.padding(.bottom, 26)
                

                
                Spacer()
            }
            .navigationBarTitle("Learning", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingSettings = true
                    }) {
                        Image(systemName: "slider.horizontal.3")
                            .imageScale(.large)
                    }
                }
            }
            .sheet(isPresented: $showingSettings) {
                TrainingSettingsView()
            }
        }
    }
}





#Preview {
    TrainingView()
        .environmentObject(Settings())
}

