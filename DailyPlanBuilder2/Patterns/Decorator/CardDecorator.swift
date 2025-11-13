import Foundation

// Component: CardPresentable (deja există)

/// Decorator de bază – ține un CardPresentable și delegă proprietățile.
class CardDecorator: CardPresentable {
    private let wrapped: CardPresentable

    init(_ wrapped: CardPresentable) {
        self.wrapped = wrapped
    }

    var id: UUID { wrapped.id }
    var title: String { wrapped.title }
    var subtitle: String { wrapped.subtitle }
}

/// Concrete Decorator – adaugă o stea la titlu pentru carduri premium.
final class StarredCardDecorator: CardDecorator {
    override var title: String {
        "★ " + super.title
    }
}
