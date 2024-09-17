import SwiftUI

struct SortOptionsView: View {
    
    @Binding var selectedSortOption: SortOption
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List {
                sortOptionRow(option: .percentageAscending, title: "By Percentage 0-100")
                sortOptionRow(option: .percentageDescending, title: "By Percentage 100-0")
                sortOptionRow(option: .nameAscending, title: "By Name A-Z")
                sortOptionRow(option: .nameDescending, title: "By Name Z-A")
                sortOptionRow(option: .dateAddedAscending, title: "By Date Added (Oldest First)")
                sortOptionRow(option: .dateAddedDescending, title: "By Date Added (Newest First)")
            }
            .navigationBarTitle("Sort Options", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func sortOptionRow(option: SortOption, title: String) -> some View {
        Button(action: {
            selectedSortOption = option
            dismiss()
        }) {
            HStack {
                Text(title)
                Spacer()
                if selectedSortOption == option {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

struct SortOptionsView_Previews: PreviewProvider {
    @State static var selectedSortOption: SortOption = .percentageAscending
    
    static var previews: some View {
        SortOptionsView(selectedSortOption: $selectedSortOption)
    }
}

