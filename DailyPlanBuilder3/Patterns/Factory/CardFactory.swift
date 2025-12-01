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


// Patterns/Factory/CardFactory.swift – doar această parte

final class PremiumCardCreator: CardCreator {
    override func makeCard(for item: PlanItem) -> CardPresentable {
        let base = super.makeCard(for: item)
        // Decorator Pattern
        return StarredCardDecorator(base)
    }
}
