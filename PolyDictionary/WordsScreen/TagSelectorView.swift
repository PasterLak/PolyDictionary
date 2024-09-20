import SwiftUI
import SwiftData

struct TagSelectorView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var tags: [Tag]
    
    @Binding var selectedTags: [Tag]
    @EnvironmentObject var settings: Settings
    @State private var newTag: String = ""
    @State private var hideTagFromOtherDictionaries: Bool = false
    @State private var selectedColor: Color = .yellow
    @State private var showMaxTagAlert: Bool = false
    @Environment(\.dismiss) var dismiss
    
    let maxTags = 5
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Add New Tag")) {
                    
                    HStack {
                        Text("#")
                        TextField("tag", text: $newTag)
                            .autocapitalization(.none)
                    }
                    
                    HStack {
                        Text("Tag Color:")
                        Spacer()
                        ForEach(TagColor.allColors(), id: \.self) { color in
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
                    Toggle(isOn: $hideTagFromOtherDictionaries) {
                        Text("Hide from other dictionaries")
                    }.toggleStyle(SwitchToggleStyle(tint: .green))
                    
                    if !newTag.isEmpty  && newTag.first != "#" && validateTagName(newTag) != "" && !isTagAlreadyExists(validateTagName(newTag)) {
                        Button(action: {
                            if selectedTags.count < maxTags {
                                
                                let newTagObj = Tag(name: validateTagName(newTag), color: TagColor.fromColor(selectedColor), isGlobal: hideTagFromOtherDictionaries)
                                
                                selectedTags.append(newTagObj) // Add the new Tag object to selectedTags
                                
                                modelContext.insert(newTagObj)
                             
                                do {
                                    try modelContext.save()
                                } catch {
                                    print("Error: \(error.localizedDescription)")
                                }

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
                    ForEach(tags) { tag in
                        HStack {
                            Text("#" + validateTagName(tag.name))
                                .foregroundColor(getColor(tag.color))
                            Spacer()
                            if selectedTags.contains(where: { $0.id == tag.id }) {
                                Image(systemName: "checkmark")
                            }
                        }
                        .contentShape(Rectangle())
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                modelContext.delete(tag)
                                try? modelContext.save()
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                // Handle edit tag
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.blue)
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
        .onAppear {
            print("Tags: \(tags)")
        }
    }
    
    private func validateTagName(_ name: String) -> String {
        var validName = name.lowercased()
        if validName.first == "#" {
            validName.removeFirst()
        }
        
        if validName.count > 12 {
            validName = String(validName.prefix(12))
        }
        
        let allowedCharacters = CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "_-"))
        if validName.rangeOfCharacter(from: allowedCharacters.inverted) != nil {
            return ""
        }
        
        return validName
    }
    
    private func isTagAlreadyExists(_ tag: String) -> Bool {
        return tags.contains { $0.name.lowercased() == tag.lowercased() }
    }
    
    private func handleTagSelection(tag: Tag) {
        if let index = selectedTags.firstIndex(where: { $0.id == tag.id }) {
            selectedTags.remove(at: index)
        } else if selectedTags.count < maxTags {
            selectedTags.append(tag)
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
    @State static var selectedTags: [Tag] = []
    
    static var previews: some View {
        NavigationView {
            TagSelectorView(selectedTags: $selectedTags)
                .environmentObject(Settings())
                .modelContainer(for: [DictionaryModel.self, Tag.self, Word.self])
        }
    }
}

