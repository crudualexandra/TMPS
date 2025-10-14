import Foundation

struct Subcategory: Identifiable {
    let id = UUID()
    let name: String
    let flashcards: [any Flashcard]
}
