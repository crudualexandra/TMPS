import SwiftUI

struct ContentView: View {
    @ObservedObject var vm: PlanViewModel

    init(vm: PlanViewModel) {
        self.vm = vm
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                // Plan preset buttons
                HStack {
                    Button("Import legacy") {
                                           vm.importLegacySampleTask()
                                       }
                    Button {
                        vm.buildDeepFocus()
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
                        vm.buildBalanced()
                        if SettingsStore.shared.hapticsEnabled {
                            let g = UIImpactFeedbackGenerator(style: .light)
                            g.impactOccurred()
                        }
                    } label: {
                        Text("Balanced Day").padding(.horizontal, 10)
                    }
                    .buttonStyle(.bordered)
                }

                // Cards list
                List(vm.cards(), id: \.id) { card in
                    CardRow(card: card)
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
            .padding()
            .navigationTitle(vm.plan.title)
            .toolbar {
                HStack {
                    Button("Theme: \(vm.theme.rawValue.capitalized)") {
                        vm.toggleTheme()
                        if SettingsStore.shared.hapticsEnabled {
                            let g = UINotificationFeedbackGenerator()
                            g.notificationOccurred(.success)
                        }
                    }
                    Button("Premium: \(vm.isPremium ? "On" : "Off")") {
                        vm.setPremium(!vm.isPremium)
                        if SettingsStore.shared.hapticsEnabled {
                            let g = UIImpactFeedbackGenerator(style: .rigid)
                            g.impactOccurred()
                        }
                    }
                }
            }
        }
        .preferredColorScheme(SettingsStore.shared.theme.colorScheme)
    }
}
