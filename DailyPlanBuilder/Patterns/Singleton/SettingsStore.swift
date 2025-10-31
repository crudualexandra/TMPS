import Foundation

/// SettingsStore is a classic Singleton:
/// - single shared instance
/// - hidden init
/// - lazy access via `shared`
final class SettingsStore {
    static let shared = SettingsStore() // lazy, single access point
    private init() {}

    enum Theme: String, CaseIterable { case system, light, dark }

    var theme: Theme = .system
    var hapticsEnabled: Bool = true
}
