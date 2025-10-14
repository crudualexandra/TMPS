
import SwiftUI

struct FlashcardView: View {
    let question: String
    let answer: String
    let isFlipped: Bool
    let onTap: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: isFlipped ? [Color.green, Color.mint] : [Color.orange, Color.pink]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(radius: 10)

            // Counter-rotate the content so text isn’t mirrored on the back
            VStack {
                Text(isFlipped ? "Answer" : "Question")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.top, 20)

                Spacer()

                Text(isFlipped ? answer : question)
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()

                Spacer()

                Text("Tap to flip")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
                    .padding(.bottom, 20)
            }
            .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0)) // <-- added
        }
        .frame(height: 400)
        .padding(.horizontal, 30)
        .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0), perspective: 0.5)
        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: isFlipped)
        .onTapGesture { onTap() }
    }
}
