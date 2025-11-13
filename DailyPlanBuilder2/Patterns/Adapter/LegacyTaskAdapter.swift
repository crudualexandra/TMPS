import Foundation

/// "Adaptee" – un format vechi de task, de exemplu primit dintr-un fișier.
struct LegacyTaskDTO {
    let categoryCode: String  // "F", "S", "W", "B"
    let duration: Int         // minute
    let note: String
}

/// Ținta (Target): ceva ce poate produce un PlanItem.
protocol PlanItemConvertible {
    func toPlanItem() -> PlanItem
}

/// Adapter: transformă LegacyTaskDTO în PlanItem.
struct LegacyTaskAdapter: PlanItemConvertible {
    let legacy: LegacyTaskDTO

    func toPlanItem() -> PlanItem {
        let kind: PlanItemKind
        switch legacy.categoryCode {
        case "F": kind = .focus
        case "S": kind = .study
        case "W": kind = .workout
        case "B": kind = .breakTime
        default:  kind = .focus
        }

        // FĂRĂ parametru id – se generează singur în struct
        return PlanItem(
            kind: kind,
            durationMinutes: legacy.duration,
            note: legacy.note
        )
    }
}
