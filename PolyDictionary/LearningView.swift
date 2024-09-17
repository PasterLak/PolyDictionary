import SwiftUI

struct LearningView: View {
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
                SettingsView2()
            }
        }
    }
}


// Модель для плиток тренировок
struct TrainingType: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
    let icon: String
}

// View для каждой плитки тренировки с анимацией нажатия
struct TrainingTileView: View {
    let training: TrainingType
    @State private var isPressed: Bool = false // Для отслеживания нажатия
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(training.color)
                .frame(height: 120)
                .shadow(color: isPressed ? .gray : .clear, radius: isPressed ? 10 : 5)
                .scaleEffect(isPressed ? 0.95 : 1.0)
                .animation(.easeInOut(duration: 0.1), value: isPressed)
                .onTapGesture {
                  
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isPressed = true
                    }
                    
                   
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isPressed = false
                        }
                       
                    }
                }
            
            HStack{
                Image(systemName: training.icon).foregroundColor(.white)
                    .shadow(color: isPressed ? .gray : .clear, radius: isPressed ? 10 : 5)
                Text(training.name)
                    .foregroundColor(.white)
                    .font(.headline)
                    .shadow(color: isPressed ? .gray : .clear, radius: isPressed ? 10 : 5)
                
            }
            
            
        }
        .scaleEffect(1.0)
    }
}

struct SettingsView2: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Settings for Learning Words")
                    .font(.headline)
                    .padding()
                Spacer()
            }
            .navigationBarTitle("Settings", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss() // Закрываем окно настроек
                    }
                }
            }
        }
    }
}

#Preview {
    LearningView()
        .environmentObject(Settings())
}

