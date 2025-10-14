import Foundation

// Base protocol for all flashcard types (LSP - Liskov Substitution Principle)
// Any flashcard type can be used interchangeably
protocol Flashcard: Identifiable {
    var id: UUID { get }
    var question: String { get }
    var answer: String { get }
}
