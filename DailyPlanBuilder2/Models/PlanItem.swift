import Foundation

enum PlanItemKind: String, CaseIterable, Identifiable {
    case focus, workout, study, breakTime
    var id: String { rawValue }
}

struct PlanItem: Identifiable, Equatable {
    let id = UUID()
    let kind: PlanItemKind
    let durationMinutes: Int
    let note: String
}
