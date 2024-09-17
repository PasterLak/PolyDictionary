import SwiftUI

struct LearningView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showingSettings = false

    let trainingTypes: [TrainingType] = [
        TrainingType(name: "Flashcards", color: .blue),
        TrainingType(name: "Writing", color: .green),
        TrainingType(name: "Listening", color: .purple),
        TrainingType(name: "Speaking", color: .orange),
        TrainingType(name: "Matching", color: .red),
        TrainingType(name: "Multiple Choice", color: .pink)
    ]

    var body: some View {
        NavigationView {
            VStack {
                // Grid с 6 плитками в два столбца
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(trainingTypes) { training in
                        TrainingTileView(training: training)
                    }
                }
                .padding()

                Spacer()
            }
            .navigationBarTitle("Learning", displayMode: .inline)
            .toolbar {
                // Кнопка закрытия
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss() // Закрываем окно
                    }
                }
                // Кнопка настроек
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingSettings = true
                    }) {
                        Image(systemName: "slider.horizontal.3")
                            .imageScale(.large)
                    }
                }
            }
            // Лист с настройками
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
                .shadow(color: isPressed ? .gray : .clear, radius: isPressed ? 10 : 5) // Эффект тени при нажатии
                .scaleEffect(isPressed ? 0.95 : 1.0) // Изменение масштаба при нажатии
                .animation(.easeInOut(duration: 0.2), value: isPressed) // Анимация
                .onTapGesture {
                    // Анимация нажатия
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isPressed = true
                    }
                    
                    // Имитация короткой задержки для эффекта нажатия
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isPressed = false
                        }
                        // Действие после нажатия (например, переход к тренировке)
                    }
                }
            
            Text(training.name)
                .foregroundColor(.white)
                .font(.headline)
        }
        .scaleEffect(1.0) // Эффект нажатия или анимации
    }
}

// Простое View для настроек
struct SettingsView2: View {
    @Environment(\.dismiss) var dismiss // Используем dismiss для закрытия окна настроек

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
}

