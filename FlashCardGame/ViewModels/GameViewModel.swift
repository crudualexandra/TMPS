import Foundation
import Combine

// SRP: Manages state for the game view
class GameViewModel: ObservableObject {
    @Published var currentFlashcards: [any Flashcard] = []
    @Published var currentIndex = 0
    @Published var isFlipped = false
    @Published var progress: Double = 0
    
    private let shuffleService: ShuffleService
    
    init(shuffleService: ShuffleService = ShuffleService()) {
        self.shuffleService = shuffleService
    }
    
    func startGame(with flashcards: [any Flashcard]) {
        currentFlashcards = shuffleService.shuffle(flashcards)
        currentIndex = 0
        isFlipped = false
        updateProgress()
    }
    
    func flipCard() {
        isFlipped.toggle()
    }
    
    func nextCard() {
        if currentIndex < currentFlashcards.count - 1 {
            currentIndex += 1
            isFlipped = false
            updateProgress()
        }
    }
    
    func previousCard() {
        if currentIndex > 0 {
            currentIndex -= 1
            isFlipped = false
            updateProgress()
        }
    }
    
    private func updateProgress() {
        progress = currentFlashcards.isEmpty ? 0 : Double(currentIndex + 1) / Double(currentFlashcards.count)
    }
    
    var currentCard: (any Flashcard)? {
        guard currentIndex < currentFlashcards.count else { return nil }
        return currentFlashcards[currentIndex]
    }
}
