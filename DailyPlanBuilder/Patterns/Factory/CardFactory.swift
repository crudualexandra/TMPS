import Foundation

/// Product protocol
protocol CardPresentable {
    var id: UUID { get }
    var title: String { get }
    var subtitle: String { get }
}

/// Concrete Products
struct TaskCard: CardPresentable {
    let id = UUID()
    let title: String
    let subtitle: String
}
struct NoteCard: CardPresentable {
    let id = UUID()
    let title: String
    let subtitle: String
}
struct TimerCard: CardPresentable {
    let id = UUID()
    let title: String
    let subtitle: String
}

/// Parameterized Factory Method variation from the book:
/// `makeCard(for:)` chooses the concrete product based on a parameter,
/// keeping clients dependent only on the CardPresentable interface.
class CardCreator {
    func makeCard(for item: PlanItem) -> CardPresentable {
        switch item.kind {
        case .focus:
            return TaskCard(title: "Focus \(item.durationMinutes)m", subtitle: item.note)
        case .study:
            return NoteCard(title: "Study \(item.durationMinutes)m", subtitle: item.note)
        case .workout:
            return TimerCard(title: "Workout \(item.durationMinutes)m", subtitle: item.note)
        case .breakTime:
            return NoteCard(title: "Break \(item.durationMinutes)m", subtitle: item.note)
        }
    }
}

/// Example of extensibility “hooks”: override factory method to tweak products.
final class PremiumCardCreator: CardCreator {
    override func makeCard(for item: PlanItem) -> CardPresentable {
        // Add a star to titles for premium users, demonstrating override flexibility.
        let starred: (String) -> String = { "★ " + $0 }
        let base = super.makeCard(for: item)
        // Wrap as new products to alter title but preserve behavior.
        switch base {
        case let t as TaskCard:
            return TaskCard(title: starred(t.title), subtitle: t.subtitle)
        case let n as NoteCard:
            return NoteCard(title: starred(n.title), subtitle: n.subtitle)
        case let tm as TimerCard:
            return TimerCard(title: starred(tm.title), subtitle: tm.subtitle)
        default:
            return base
        }
    }
}
