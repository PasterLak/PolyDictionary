import SwiftUI


struct OnboardingPageView: View {
    var page: OnboardingPage
    @Binding var animateImage: Bool
    @Binding var animateText: Bool
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(page.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .opacity(animateText ? 1 : 0.5)
                .offset(y: animateText ? 0 : 5)
                .animation(.easeInOut(duration: 0.5))
            
            Spacer()
            
            Image(page.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 350, height: 350)
                .clipShape(Circle())
                .shadow(radius: 10)
                .scaleEffect(animateImage ? 1 : 0.8)
                .animation(.easeOut(duration: 0.8))
            
            Text(page.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .opacity(animateText ? 1 : 0.8)
                .offset(y: animateText ? 0 : 10)
                .animation(.easeInOut(duration: 0.6).delay(0.2))
            
            Spacer()
        }
        .preferredColorScheme(settings.isDarkMode ? .dark : .light)
        .padding()
    }
}


