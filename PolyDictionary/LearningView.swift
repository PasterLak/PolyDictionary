import SwiftUI

struct LearningView: View {
    var body: some View {
        NavigationView {
            VStack {
                /*Text("Learning")
                    .font(.largeTitle)
                    .padding()
                Spacer()*/
            }
            .navigationBarTitle("Learning", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    //Button("Закрыть") {
                        // Автоматически закрывается свайпом вниз или кнопкой "Закрыть"
                    //}
                }
            }
        }
    }
}

#Preview {
    LearningView()
}
