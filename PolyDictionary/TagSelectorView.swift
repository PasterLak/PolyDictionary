import SwiftUI

struct Tag: Identifiable {
    let id = UUID()
    let name: String
    var color: Color
}

struct TagSelectorView: View {
    
    @Binding var selectedTags: [String]
    
    @EnvironmentObject var settings: Settings
    
    @State private var newTag: String = ""
    @State private var availableTags: [Tag] = [
        Tag(name: "Verb", color: .yellow),
        Tag(name: "Noun", color: .yellow),
        Tag(name: "Adjective", color: .yellow)
    ]
    @State private var selectedColor: Color = .yellow
    
    @Environment(\.dismiss) var dismiss
    
    let availableColors: [Color] = [.yellow, .blue, .green, .red, .purple]
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Add New Tag")) {
                    TextField("#tag", text: $newTag)
                    
                   
                    HStack {
                        Text("Tag Color:")
                        Spacer()
                        ForEach(availableColors, id: \.self) { color in
                            Circle()
                                .fill(color)
                                .shadow(radius: 5)
                                .frame(width: 25, height: 25)
                                .onTapGesture {
                                    selectedColor = color // Выбор цвета
                                }
                                .overlay(
                                    Circle()
                                        //.shadow(radius: 7)
                                        .stroke( Color.white,
                                                lineWidth: selectedColor == color ? 4 : 0)
                                )
                        }
                    }
                    
                    if newTag != "" {
                        Button(action: {
                            guard !newTag.isEmpty else { return }
                            let newTagObj = Tag(name: newTag, color: selectedColor)
                            availableTags.append(newTagObj)
                            selectedTags.append(newTag)
                            newTag = ""
                            selectedColor = .yellow // Сброс цвета на стандартный
                        }) {
                            Text("Add")
                                .foregroundColor(.blue)
                        }
                    }
                }
                
                Section(header: Text("Available Tags")) {
                    ForEach(availableTags) { tag in
                        HStack {
                            Text("#" + tag.name.lowercased())
                            
                                .foregroundColor(getColor(tag.color))
                                //.bold()
                            Spacer()
                           // Circle()
                            //    .fill(tag.color)
                            //    .frame(width: 20, height: 20) // Показываем цвет тега
                            if selectedTags.contains(tag.name) {
                                Image(systemName: "checkmark")
                            }
                        }
                        .onTapGesture {
                            if selectedTags.contains(tag.name) {
                                selectedTags.removeAll(where: { $0 == tag.name })
                            } else {
                                selectedTags.append(tag.name)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Select Tags", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Close") {
                    dismiss() // Закрываем окно
                },
                trailing: Button("Done") {
                    dismiss() // Закрываем окно
                }
            )
        }
        
        
    }
    
    func getColor(_ color: Color) -> Color
    {
        if color == .yellow
        {
            if settings.isDarkMode
            {
                return .yellow
            }
            else
            {
                return Color(red: 0.95, green: 0.6, blue: 0.1)
            }
            
        }
        
        return color
    }
}

struct TagSelectorView_Previews: PreviewProvider {
    @State static var selectedTags: [String] = []
    
    static var previews: some View {
        NavigationView {
            TagSelectorView(selectedTags: $selectedTags)
                .environmentObject(Settings())
        }
    }
}

