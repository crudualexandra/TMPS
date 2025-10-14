import SwiftUI

struct GameView: View {
    let subcategory: Subcategory
    @StateObject private var viewModel = GameViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            // Progress bar
            ProgressView(value: viewModel.progress)
                .padding()
            
            Text("Card \(viewModel.currentIndex + 1) of \(viewModel.currentFlashcards.count)")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Spacer()
            
            if let card = viewModel.currentCard {
                FlashcardView(
                    question: card.question,
                    answer: card.answer,
                    isFlipped: viewModel.isFlipped
                ) {
                    viewModel.flipCard()
                }
            }
            
            Spacer()
            
            // Navigation buttons
            HStack(spacing: 30) {
                Button(action: viewModel.previousCard) {
                    Image(systemName: "chevron.left.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(viewModel.currentIndex > 0 ? .blue : .gray)
                }
                .disabled(viewModel.currentIndex == 0)
                
                Button(action: viewModel.nextCard) {
                    Image(systemName: "chevron.right.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(viewModel.currentIndex < viewModel.currentFlashcards.count - 1 ? .blue : .gray)
                }
                .disabled(viewModel.currentIndex >= viewModel.currentFlashcards.count - 1)
            }
            .padding(.bottom, 30)
        }
        .navigationTitle(subcategory.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.startGame(with: subcategory.flashcards)
        }
    }
}
