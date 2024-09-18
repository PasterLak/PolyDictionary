import SwiftUI


struct WordAddedMessage: View {
    var body: some View {
        Text("Word added successfully")
            .foregroundColor(.white)
            .padding(.horizontal)
            
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .background(Color.green)
            .cornerRadius(5)
        //.transition(.move(edge: .top))
            .zIndex(1)
            //.shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        
    }
}

#Preview {
    WordAddedMessage()
}
