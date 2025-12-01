import Foundation

/// Fațadă – interfață unică prin care clientul vorbește cu sistemul.
/// Clientul unic este ContentView.
protocol PlanningFacade: AnyObject {
    var plan: DailyPlan { get }
    var theme: SettingsStore.Theme { get }
    var isPremium: Bool { get }

    func buildDeepFocus()
    func buildBalanced()
    func toggleTheme()
    func setPremium(_ enabled: Bool)
    func cards() -> [CardPresentable]
}

extension PlanViewModel: PlanningFacade {}
