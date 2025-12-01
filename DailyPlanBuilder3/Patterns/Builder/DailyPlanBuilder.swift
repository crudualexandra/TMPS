import Foundation

//interfata builder
protocol DailyPlanBuilder {
    func reset(title: String)
    func addFocus(minutes: Int, note: String)
    func addStudy(minutes: Int, note: String)
    func addWorkout(minutes: Int, note: String)
    func addBreak(minutes: Int, note: String)
    func build() -> DailyPlan
}

/// Concrete Builder #1: Deep Focus preset representation
final class DeepFocusPlanBuilder: DailyPlanBuilder {
    private var title: String = ""
    private var items: [PlanItem] = []

    func reset(title: String) {
        self.title = title
        self.items.removeAll()
    }

    func addFocus(minutes: Int, note: String) {
        items.append(.init(kind: .focus, durationMinutes: minutes, note: note))
    }
    func addStudy(minutes: Int, note: String) {
        items.append(.init(kind: .study, durationMinutes: minutes, note: note))
    }
    func addWorkout(minutes: Int, note: String) {
        items.append(.init(kind: .workout, durationMinutes: minutes, note: note))
    }
    func addBreak(minutes: Int, note: String) {
        items.append(.init(kind: .breakTime, durationMinutes: minutes, note: note))
    }

    func build() -> DailyPlan {
        DailyPlan(title: title, items: items)
    }
}

/// Concrete Builder #2: Balanced Day preset representation
final class BalancedPlanBuilder: DailyPlanBuilder {
    private var title: String = ""
    private var items: [PlanItem] = []

    func reset(title: String) {
        self.title = title
        self.items.removeAll()
    }

    func addFocus(minutes: Int, note: String) {
        items.append(.init(kind: .focus, durationMinutes: minutes, note: note))
    }
    func addStudy(minutes: Int, note: String) {
        items.append(.init(kind: .study, durationMinutes: minutes, note: note))
    }
    func addWorkout(minutes: Int, note: String) {
        items.append(.init(kind: .workout, durationMinutes: minutes, note: note))
    }
    func addBreak(minutes: Int, note: String) {
        items.append(.init(kind: .breakTime, durationMinutes: minutes, note: note))
    }

    func build() -> DailyPlan {
        DailyPlan(title: title, items: items)
    }
}
