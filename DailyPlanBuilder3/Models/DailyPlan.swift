import Foundation

struct DailyPlan: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var items: [PlanItem]
}
