import SwiftUI

@main
struct DailyPlanBuilderApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(vm: PlanViewModel())
        }
    }
}
