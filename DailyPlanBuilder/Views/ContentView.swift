import SwiftUI

struct ContentView: View {
    @ObservedObject var vm: PlanViewModel

    init(vm: PlanViewModel) {
        self.vm = vm
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                HStack {
                    Button("Deep Focus Day") { vm.buildDeepFocus() }
                        .buttonStyle(.borderedProminent)
                    Button("Balanced Day") { vm.buildBalanced() }
                        .buttonStyle(.bordered)
                }

                List(vm.cards(), id: \.id) { card in
                    CardRow(card: card)
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
            .padding()
            .navigationTitle(vm.plan.title)
            .toolbar {
                Button("Theme: \(vm.theme.rawValue.capitalized)") {
                    vm.toggleTheme()
                }
            }
        }
    }
}
