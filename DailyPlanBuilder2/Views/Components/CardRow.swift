import SwiftUI

struct CardRow: View {
    let card: CardPresentable

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(card.title)
                .font(.headline)
            Text(card.subtitle)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
        )
    }
}
