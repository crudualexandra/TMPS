import Foundation

struct Category: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let subcategories: [Subcategory]
}
