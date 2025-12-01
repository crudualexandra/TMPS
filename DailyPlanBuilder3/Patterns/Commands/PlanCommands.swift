import Foundation

// MARK: - Command

/// Command – interfață comună pentru toate comenzile asupra planului.
protocol PlanCommand {
    func execute()
}

/// Receiver-ul este PlanViewModel (nu îl definim aici, doar îl referim).
final class BuildDeepFocusCommand: PlanCommand {
    private weak var receiver: PlanViewModel?

    init(receiver: PlanViewModel) {
        self.receiver = receiver
    }

    func execute() {
        receiver?.buildDeepFocus()
    }
}

final class BuildBalancedCommand: PlanCommand {
    private weak var receiver: PlanViewModel?

    init(receiver: PlanViewModel) {
        self.receiver = receiver
    }

    func execute() {
        receiver?.buildBalanced()
    }
}

final class ToggleThemeCommand: PlanCommand {
    private weak var receiver: PlanViewModel?

    init(receiver: PlanViewModel) {
        self.receiver = receiver
    }

    func execute() {
        receiver?.toggleTheme()
    }
}

final class TogglePremiumCommand: PlanCommand {
    private weak var receiver: PlanViewModel?

    init(receiver: PlanViewModel) {
        self.receiver = receiver
    }

    func execute() {
        guard let vm = receiver else { return }
        vm.setPremium(!vm.isPremium)
    }
}

/// Invoker – execută comenzile trimise de client (ContentView).
final class PlanCommandInvoker {
    func execute(_ command: PlanCommand) {
        command.execute()
    }
}
