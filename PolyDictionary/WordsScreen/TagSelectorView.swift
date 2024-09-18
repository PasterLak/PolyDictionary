import SwiftUI

struct TagSelectorView: View {
    
    @Binding var selectedTags: [String]
    @EnvironmentObject var settings: Settings
    @State private var newTag: String = ""
    @State private var availableTags: [Tag] = [
        Tag(name: "art", color: .purple),
        Tag(name: "new", color: .green),
        Tag(name: "food", color: .yellow),
        Tag(name: "verb", color: .yellow),
        Tag(name: "noun", color: .yellow),
        Tag(name: "adjective", color: .yellow)
    ]
    @State private var selectedColor: Color = .yellow
    @State private var showMaxTagAlert: Bool = false
    @Environment(\.dismiss) var dismiss
    
    let availableColors: [Color] = [.yellow, .blue, .green, .red, .purple]
    let maxTags = 5
    
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
                                    selectedColor = color
                                }
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: selectedColor == color ? 4 : 0)
                                )
                        }
                    }
                    
                    if !newTag.isEmpty {
                        Button(action: {
                            if selectedTags.count < maxTags {
                                let newTagObj = Tag(name: newTag, color: selectedColor)
                                availableTags.append(newTagObj)
                                selectedTags.append(newTag)
                                newTag = ""
                                selectedColor = .yellow
                            } else {
                                showMaxTagAlert = true
                            }
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
                            Spacer()
                            if selectedTags.contains(tag.name) {
                                Image(systemName: "checkmark")
                            }
                        }
                        .onTapGesture {
                            handleTagSelection(tag: tag)
                        }
                    }
                }
            }
            .navigationBarTitle("Select Tags", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Close") {
                    dismiss()
                },
                trailing: Button("Done") {
                    dismiss()
                }
            )
            .alert(isPresented: $showMaxTagAlert) {
                Alert(title: Text("Maximum number of selected tags reached!"), message: Text("You can select up to \(maxTags) tags."), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func handleTagSelection(tag: Tag) {
        if selectedTags.contains(tag.name) {
            selectedTags.removeAll(where: { $0 == tag.name })
        } else if selectedTags.count < maxTags {
            selectedTags.append(tag.name)
        } else {
            showMaxTagAlert = true
        }
    }
    
    func getColor(_ color: Color) -> Color {
        if color == .yellow {
            return settings.isDarkMode ? .yellow : Color(red: 0.95, green: 0.6, blue: 0.1)
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

