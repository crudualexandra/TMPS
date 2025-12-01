import Foundation

final class PlanViewModel: ObservableObject, PlanSubject {
    @Published var plan: DailyPlan = DailyPlan(title: "Empty", items: [])
    @Published var theme: SettingsStore.Theme = SettingsStore.shared.theme
    @Published var isPremium: Bool

    // Strategy: numele strategiei curente (pentru UI)
    @Published var currentStrategyName: String

    private let director = PlanDirector()
    private let deepBuilder: DailyPlanBuilder = DeepFocusPlanBuilder()
    private let balancedBuilder: DailyPlanBuilder = BalancedPlanBuilder()
    private var cardFactory: CardCreator

    // Strategy + Observer
    private var orderingStrategy: CardOrderingStrategy
    private var observers: [PlanObserver] = []

    init(premium: Bool = false) {
        self.isPremium = premium
        self.cardFactory = premium ? PremiumCardCreator() : CardCreator()

        // strategie implicită
        self.orderingStrategy = OriginalOrderStrategy()
        self.currentStrategyName = orderingStrategy.name
    }

    func buildDeepFocus() {
        plan = director.makeDeepFocusDay(with: deepBuilder)
        notifyObservers()
    }

    func buildBalanced() {
        plan = director.makeBalancedDay(with: balancedBuilder)
        notifyObservers()
    }

    func cards() -> [CardPresentable] {
        // Strategy: ordonează item-urile înainte să le transforme în carduri
        let orderedItems = orderingStrategy.order(plan.items)
        return orderedItems.map { cardFactory.makeCard(for: $0) }
    }

    func toggleTheme() {
        switch theme {
        case .system: theme = .light
        case .light: theme = .dark
        case .dark: theme = .system
        }
        SettingsStore.shared.theme = theme
    }

    func setPremium(_ enabled: Bool) {
        isPremium = enabled
        cardFactory = enabled ? PremiumCardCreator() : CardCreator()
        // Re-publicăm, pentru că stelele pot apărea/dispare
        objectWillChange.send()
    }

    // folosit de Adapter (legacy → PlanItem)
    func importLegacySampleTask() {
        let legacy = LegacyTaskDTO(
            categoryCode: "F",
            duration: 25,
            note: "Legacy focus task"
        )

        let adapter = LegacyTaskAdapter(legacy: legacy)
        let item = adapter.toPlanItem()
        plan.items.append(item)
        notifyObservers()
    }

    // MARK: - Strategy API

    /// Activează/dezactivează strategia de ordonare după durată.
    func useDurationStrategy(_ enabled: Bool) {
        orderingStrategy = enabled ? DurationDescendingStrategy() : OriginalOrderStrategy()
        currentStrategyName = orderingStrategy.name
    }

    // MARK: - PlanSubject (Observer)

    func addObserver(_ observer: PlanObserver) {
        observers.append(observer)
    }

    func removeObserver(_ observer: PlanObserver) {
        observers.removeAll { $0 === observer }
    }

    private func notifyObservers() {
        for o in observers {
            o.planDidChange(plan)
        }
    }
}
