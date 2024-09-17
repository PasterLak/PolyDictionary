import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var settings: Settings
    //@StateObject var languageManager = LanguageManager()
    
    @Binding var showOnboarding: Bool
    @State private var currentPage = 0
    @State private var animateImage = false
    @State private var animateText = false // Новая переменная для анимации текста
    
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
                        .transition(.slide) // Плавный слайд-переход между страницами
                        .onAppear {
                            // При появлении новой страницы запускаем анимации
                            withAnimation(.easeInOut(duration: 1)) {
                                animateImage = true
                            }
                            withAnimation(.easeInOut(duration: 1.0).delay(0.3)) {
                                animateText = true
                            }
                        }
                        .onChange(of: currentPage) { _ in
                            // Перезапускаем анимации при смене страницы
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
            .animation(.easeInOut) // Плавная анимация смены страниц
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            // Кнопка "Далее"
            Button(action: {
                if currentPage < pages.count - 1 {
                    withAnimation {
                        currentPage += 1
                    }
                } else {
                    withAnimation(.easeInOut(duration: 1)) {
                        showOnboarding = false // Плавно скрываем OnboardingView
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
                    .shadow(radius: 5) // Добавляем тень для кнопки
                    .padding(.horizontal)
            }
            .padding(.bottom, 50)
        }
        .preferredColorScheme(settings.isDarkMode ? .dark : .light)
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}

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
                .opacity(animateText ? 1 : 0.5) // Анимация появления текста
                .offset(y: animateText ? 0 : 5) // Плавное появление сдвигается вверх
                .animation(.easeInOut(duration: 0.5)) // Плавная анимация заголовка
            
            Spacer()
            
            Image(page.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 350, height: 350)
                .clipShape(Circle())
                .shadow(radius: 10)
                .scaleEffect(animateImage ? 1 : 0.8) // Плавное увеличение изображения
                .animation(.easeOut(duration: 0.8)) // Анимация появления изображения
            
            Text(page.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .opacity(animateText ? 1 : 0.8) // Плавная анимация появления текста
                .offset(y: animateText ? 0 : 10) // Текст начинается снизу и поднимается вверх
                .animation(.easeInOut(duration: 0.6).delay(0.2)) // Плавная анимация с задержкой
            
            
            Spacer()
        }
        .preferredColorScheme(settings.isDarkMode ? .dark : .light)
        .padding()
    }
}

struct OnboardingPage {
    let title: String
    let description: String
    let image: String
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        @State var showOnboarding = true
        OnboardingView(showOnboarding: $showOnboarding)
    }
}

