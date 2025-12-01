# Laboratory 3


Class: TMPS

**Behavioral Design Patterns**

## **1. Theoretical Overview of Behavioral Patterns**

- **Chain of Responsibility** – passes a request along a chain of handlers until one of them handles it, decoupling the sender from the receiver.
- **Command** – encapsulates a request as an object with a standard execute() method, allowing operations to be queued, logged, undone, or triggered uniformly.
- **Interpreter** – defines a grammar and an interpreter to evaluate expressions in a small domain-specific language.
- **Iterator** – provides a standard way to traverse elements in a collection without exposing its internal representation.
- **Mediator** – centralizes communication between objects so they do not refer to each other directly.
- **Memento** – captures and restores an object’s internal state without breaking encapsulation.
- **Observer** – defines a one-to-many dependency where all observers are notified when the subject’s state changes.
- **State** – allows an object to change its behavior when its internal state changes, appearing to be a different class.
- **Strategy** – defines a family of algorithms, encapsulates them, and makes them interchangeable at runtime.
- **Template Method** – defines the skeleton of an algorithm in a base class while allowing subclasses to implement specific steps.
- **Visitor** – separates an algorithm from the object structure it operates on, enabling new operations without modifying existing classes.

## **2. Implementation of Behavioral Patterns in “Daily Plan Builder”**

Three behavioral patterns were implemented exactly according to the structures: **Command**, **Observer**, and **Strategy**.

The single client of the whole system is **ContentView**, while **PlanViewModel** acts as the subsystem façade.

**2.1. Command Pattern**
**Client → Invoker → Command → ConcreteCommand → Receiver**

**Mapping in the application:**

|  **Role** | **Class** |
| --- | --- |
| Client | ContentView |
| Invoker | PlanCommandInvoker |
| Command | PlanCommand protocol |
| ConcreteCommand | BuildDeepFocusCommand, BuildBalancedCommand, ToggleThemeCommand, TogglePremiumCommand |
| Receiver | PlanViewModel |

**Code snippet :**

```bash

protocol PlanCommand { func execute() }

final class BuildDeepFocusCommand: PlanCommand {
private weak var receiver: PlanViewModel?
init(receiver: PlanViewModel) { self.receiver = receiver }
func execute() { receiver?.buildDeepFocus() }
}

final class PlanCommandInvoker {
func execute(_ cmd: PlanCommand) { cmd.execute() }
}

```

**Usage in ContentView:**
```bash

commandInvoker.execute(
BuildDeepFocusCommand(receiver: vm)
)

```

- ContentView creates a command object → **Client**
- sends it to the PlanCommandInvoker → **Invoker**
- which calls execute() → **Command**
- which triggers the real function inside PlanViewModel → **Receiver**

Command helps decouple the UI buttons from the actual logic by turning each action into an object; in our app it cleanly triggers plan-building, theme switching, and premium toggling through command objects instead of direct calls.

**2.2. Observer Pattern**

**Subject → ConcreteSubject**

**Observer → ConcreteObserver**

**Mapping in the application:**

| **Role** | **Class** |
| --- | --- |
| Subject | PlanSubject protocol |
| ConcreteSubject | PlanViewModel |
| Observer | PlanObserver protocol |
| ConcreteObserver | PlanStatistics |

**Code snippet:**
```bash

protocol PlanObserver: AnyObject {
func planDidChange(_ plan: DailyPlan)
}

protocol PlanSubject: AnyObject {
func addObserver(_ o: PlanObserver)
func removeObserver(_ o: PlanObserver)
}

final class PlanStatistics: ObservableObject, PlanObserver {
@Published private(set) var plansBuiltCount = 0
func planDidChange(_ plan: DailyPlan) {
plansBuiltCount += 1
}
}

```

**PlanViewModel as Subject:**
```bash

private var observers: [PlanObserver] = []

func buildDeepFocus() {
plan = ...
notifyObservers()
}

private func notifyObservers() {
for o in observers { o.planDidChange(plan) }
}

```

**Usage in ContentView:**

```bash

@StateObject private var stats = PlanStatistics()
.onAppear { vm.addObserver(stats) }

Text("Plans built: \(stats.plansBuiltCount)")

```

- PlanViewModel keeps track of observers → **ConcreteSubject**
- PlanStatistics updates itself when notified → **ConcreteObserver**

**Observer**  keeps different parts of the app automatically updated when the plan changes; in our app it updates the “Plans built” counter every time a new plan is generated.

**2.3. Strategy Pattern**
**Context → Strategy → ConcreteStrategyA/B/C**

**Mapping in the application:**

| **Role** | **Class** |
| --- | --- |
| Context | PlanViewModel |
| Strategy | CardOrderingStrategy |
| Concrete Strategies | OriginalOrderStrategy, DurationDescendingStrategy |
| Client | ContentView (changes the strategy) |

**Code snippet:**
```bash

protocol CardOrderingStrategy {
var name: String { get }
func order(_ items: [PlanItem]) -> [PlanItem]
}

struct OriginalOrderStrategy: CardOrderingStrategy {
let name = "Original"
func order(_ items: [PlanItem]) -> [PlanItem] { items }
}

struct DurationDescendingStrategy: CardOrderingStrategy {
let name = "Duration"
func order(_ items: [PlanItem]) -> [PlanItem] {
items.sorted { $0.durationMinutes > $1.durationMinutes }
}
}

```

**Context (PlanViewModel):**
```bash

private var orderingStrategy: CardOrderingStrategy = OriginalOrderStrategy()

func cards() -> [CardPresentable] {
let ordered = orderingStrategy.order(plan.items)
return ordered.map { cardFactory.makeCard(for: $0) }
}

func useDurationStrategy(_ enabled: Bool) {
orderingStrategy = enabled ? DurationDescendingStrategy() : OriginalOrderStrategy()
}

```

**Usage in ContentView:**

```bash

Button("Strategy: \(vm.currentStrategyName)") {
useDurationStrategy.toggle()
vm.useDurationStrategy(useDurationStrategy)
}

```

- PlanViewModel → **Context**
- holds a reference to a CardOrderingStrategy → **Strategy**
- switching strategies changes the ordering behavior dynamically.

**Strategy**  allows switching between different algorithms at runtime; in our app it changes how plan items are ordered (original order or sorted by duration) without modifying any existing logic.

**3. Conclusion**

In this laboratory, we analyzed the major behavioral design patterns from the GoF standard catalog and implemented three of them—**Command**, **Observer**, and **Strategy**—in the “Daily Plan Builder” application. The implementations strictly follow the original structures: Command with Client–Invoker–Receiver separation, Observer with Subject and ConcreteObserver relationships, and Strategy with a Context dynamically switching between algorithms.

Combined with the creational and structural patterns from the previous laboratory, the project now demonstrates a complete multi-pattern architecture where each pattern serves a clear purpose: modularity, extensibility, loose coupling, and a single well-defined client (ContentView).
