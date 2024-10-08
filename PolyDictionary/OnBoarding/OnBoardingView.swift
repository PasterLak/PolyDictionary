import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var settings: Settings
    //@StateObject var languageManager = LanguageManager()
    
    @Binding var showOnboarding: Bool
    @State private var currentPage = 0
    @State private var animateImage = false
    @State private var animateText = false
    
    let pages = [
        OnboardingPage(title: NSLocalizedString("onboarding.welcome", comment: ""), description: NSLocalizedString("onboarding.description1", comment: ""), image: "onboarding1"),
        OnboardingPage(title: NSLocalizedString("onboarding.organizeWords", comment: ""), description: NSLocalizedString("onboarding.description2", comment: ""), image: "onboarding2"),
        OnboardingPage(title: NSLocalizedString("onboarding.trackProgress", comment: ""), description: NSLocalizedString("onboarding.description3", comment: ""), image: "onboarding3")
    ]
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(0..<pages.count, id: \.self) { index in
                    OnboardingPageView(page: pages[index], animateImage: $animateImage, animateText: $animateText)
                        .tag(index)
                        .transition(.slide)
                        .onAppear {
                            
                            withAnimation(.easeInOut(duration: 1)) {
                                animateImage = true
                            }
                            withAnimation(.easeInOut(duration: 1.0).delay(0.3)) {
                                animateText = true
                            }
                        }
                        .onChange(of: currentPage) { _ in
                           
                            animateImage = false
                            animateText = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                withAnimation(.easeInOut(duration: 0.8)) {
                                    animateImage = true
                                }
                                withAnimation(.easeInOut(duration: 1.0).delay(0.3)) {
                                    animateText = true
                                }
                            }
                        }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .animation(.easeInOut)
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
          
            Button(action: {
                if currentPage < pages.count - 1 {
                    withAnimation {
                        currentPage += 1
                    }
                } else {
                    withAnimation(.easeInOut(duration: 1)) {
                        showOnboarding = false
                    }
                }
            }) {
                Text(currentPage < pages.count - 1 ? "Next" : "Get Started")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal)
            }
            .padding(.bottom, 50)
        }
        .preferredColorScheme(settings.isDarkMode ? .dark : .light)
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        @State var showOnboarding = true
        OnboardingView(showOnboarding: $showOnboarding)
    }
}

