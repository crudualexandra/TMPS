import SwiftUI

struct ContentView: View {
    @ObservedObject var vm: PlanViewModel

    // Observer concret – colectează statistici despre planuri
    @StateObject private var stats = PlanStatistics()

    // Strategy toggle
    @State private var useDurationStrategy = false

    // Invoker pentru Command
    private let commandInvoker = PlanCommandInvoker()

    init(vm: PlanViewModel) {
        self.vm = vm
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                // Buton Adapter (import legacy)
                HStack {
                    Button("Import legacy") {
                        vm.importLegacySampleTask()
                    }

                    Spacer()
                }

                // Plan preset buttons (Command)
                HStack {
                    Button {
                        commandInvoker.execute(
                            BuildDeepFocusCommand(receiver: vm)
                        )
                        if SettingsStore.shared.hapticsEnabled {
                            let g = UIImpactFeedbackGenerator(style: .light)
                            g.impactOccurred()
                        }
                    } label: {
                        Text("Deep Focus Day").padding(.horizontal, 10)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)

                    Button {
                        commandInvoker.execute(
                            BuildBalancedCommand(receiver: vm)
                        )
                        if SettingsStore.shared.hapticsEnabled {
                            let g = UIImpactFeedbackGenerator(style: .light)
                            g.impactOccurred()
                        }
                    } label: {
                        Text("Balanced Day").padding(.horizontal, 10)
                    }
                    .buttonStyle(.bordered)
                }

                // Strategy selector – schimbă ordinea cardurilor
                Button("Strategy: \(vm.currentStrategyName)") {
                    useDurationStrategy.toggle()
                    vm.useDurationStrategy(useDurationStrategy)
                }
                .buttonStyle(.bordered)

                // Cards list
                List(vm.cards(), id: \.id) { card in
                    CardRow(card: card)
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)

                // Info de la Observer
                Text("Plans built: \(stats.plansBuiltCount)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .navigationTitle(vm.plan.title)
            .toolbar {
                HStack {
                    Button("Theme: \(vm.theme.rawValue.capitalized)") {
                        commandInvoker.execute(
                            ToggleThemeCommand(receiver: vm)
                        )
                        if SettingsStore.shared.hapticsEnabled {
                            let g = UINotificationFeedbackGenerator()
                            g.notificationOccurred(.success)
                        }
                    }
                    Button("Premium: \(vm.isPremium ? "On" : "Off")") {
                        commandInvoker.execute(
                            TogglePremiumCommand(receiver: vm)
                        )
                        if SettingsStore.shared.hapticsEnabled {
                            let g = UIImpactFeedbackGenerator(style: .rigid)
                            g.impactOccurred()
                        }
                    }
                }
            }
            .onAppear {
                vm.addObserver(stats)
            }
            .onDisappear {
                vm.removeObserver(stats)
            }
        }
        .preferredColorScheme(SettingsStore.shared.theme.colorScheme)
    }
}
