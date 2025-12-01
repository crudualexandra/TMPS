import Foundation

// MARK: - Strategy

/// Strategy – definește modul în care sunt ordonate item-urile unui plan.
protocol CardOrderingStrategy {
    var name: String { get }
    func order(_ items: [PlanItem]) -> [PlanItem]
}

/// Strategie implicită: păstrează ordinea originală.
struct OriginalOrderStrategy: CardOrderingStrategy {
    let name = "Original"

    func order(_ items: [PlanItem]) -> [PlanItem] {
        items
    }
}

/// Strategie alternativă: ordonează descrescător după durată.
struct DurationDescendingStrategy: CardOrderingStrategy {
    let name = "Duration"

    func order(_ items: [PlanItem]) -> [PlanItem] {
        items.sorted { $0.durationMinutes > $1.durationMinutes }
    }
}
