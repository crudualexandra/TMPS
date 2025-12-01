import Foundation

// MARK: - Observer

/// Observer – este notificat când planul se schimbă.
protocol PlanObserver: AnyObject {
    func planDidChange(_ plan: DailyPlan)
}

/// Subject – interfață pentru obiecte care acceptă observatori.
protocol PlanSubject: AnyObject {
    func addObserver(_ observer: PlanObserver)
    func removeObserver(_ observer: PlanObserver)
}

/// Concrete Observer – ține statistici simple despre planuri.
final class PlanStatistics: ObservableObject, PlanObserver {
    @Published private(set) var plansBuiltCount: Int = 0

    func planDidChange(_ plan: DailyPlan) {
        plansBuiltCount += 1
    }
}
