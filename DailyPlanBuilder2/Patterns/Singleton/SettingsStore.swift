import Foundation
import SwiftUI


final class SettingsStore {
    static let shared = SettingsStore()
    private init() {}

    enum Theme: String, CaseIterable { case system, light, dark }

    var theme: Theme = .system
    var hapticsEnabled: Bool = true
}

extension SettingsStore.Theme {
 
    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light:  return .light
        case .dark:   return .dark
        }
    }
}
