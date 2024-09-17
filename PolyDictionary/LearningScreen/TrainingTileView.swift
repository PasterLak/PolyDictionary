import SwiftUI

struct TrainingTileView: View {
    
    let training: TrainingType
    @State private var isPressed: Bool = false
    
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


#Preview {
    TrainingTileView(training: TrainingType(name: "Flashcards", color: .blue, icon: "menucard.fill"))
}
