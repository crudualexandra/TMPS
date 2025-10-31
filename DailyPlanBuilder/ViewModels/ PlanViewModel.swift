import Foundation

final class PlanViewModel: ObservableObject {
    @Published var plan: DailyPlan = DailyPlan(title: "Empty", items: [])
    @Published var theme: SettingsStore.Theme = SettingsStore.shared.theme

    private let director = PlanDirector()
    private let deepBuilder: DailyPlanBuilder = DeepFocusPlanBuilder()
    private let balancedBuilder: DailyPlanBuilder = BalancedPlanBuilder()
    private let cardFactory: CardCreator

    init(premium: Bool = false) {
        // Show how Factory Method can be swapped without touching clients
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
        // read/write through the Singleton
        switch theme {
        case .system: theme = .light
        case .light: theme = .dark
        case .dark: theme = .system
        }
        SettingsStore.shared.theme = theme
    }
}
