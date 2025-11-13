import Foundation

final class PlanViewModel: ObservableObject {
    @Published var plan: DailyPlan = DailyPlan(title: "Empty", items: [])
    @Published var theme: SettingsStore.Theme = SettingsStore.shared.theme
    @Published var isPremium: Bool

    private let director = PlanDirector()
    private let deepBuilder: DailyPlanBuilder = DeepFocusPlanBuilder()
    private let balancedBuilder: DailyPlanBuilder = BalancedPlanBuilder()
    private var cardFactory: CardCreator

    init(premium: Bool = false) {
        self.isPremium = premium
        self.cardFactory = premium ? PremiumCardCreator() : CardCreator()
    }

    func buildDeepFocus() {
        plan = director.makeDeepFocusDay(with: deepBuilder)
    }

    func buildBalanced() {
        plan = director.makeBalancedDay(with: balancedBuilder)
    }

    func cards() -> [CardPresentable] {
        plan.items.map { cardFactory.makeCard(for: $0) }
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
        // Re-publish current plan as new cards will differ (stars on/off)
        objectWillChange.send()
    }
    func importLegacySampleTask() {
            // un "task vechi" venit din alt sistem
            let legacy = LegacyTaskDTO(categoryCode: "F",
                                       duration: 25,
                                       note: "Legacy focus task")

            let adapter = LegacyTaskAdapter(legacy: legacy)
            let item = adapter.toPlanItem()
            plan.items.append(item)
        }
}
