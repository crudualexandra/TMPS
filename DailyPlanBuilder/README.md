# Laboratory 1

Created: October 31, 2025 3:04 PM
Class: TMPS

**Laboratory Report – Creational Design Patterns**

In this laboratory work, we developed an iOS application called **“Daily Plan Builder”** using Swift and SwiftUI.

The purpose of the app is to demonstrate the practical implementation of **three creational design patterns**: **Singleton**, **Factory Method**, and **Builder**.

Additionally, we studied and described the remaining two creational patterns — **Abstract Factory** and **Prototype** — to understand how they could be applied in larger systems.

### **Implemented Creational Patterns**

### **1. Singleton Pattern**

**Purpose:**

Ensures that only one instance of a class exists and provides a global access point to it.

**Implementation:**

We used Singleton for managing user preferences such as theme and haptic settings.

```bash

final class SettingsStore {
static let shared = SettingsStore()  // single global instance
private init() {}                    // private constructor

var theme: Theme = .system
var hapticsEnabled: Bool = true



}

```

**Usage Example:**

```bash

SettingsStore.shared.theme = .dark

```

This guarantees a single consistent configuration object across the app.

**2. Factory Method Pattern**

**Purpose:**

Defines an interface for creating an object but lets subclasses decide which class to instantiate.

This allows flexibility in product creation without changing client code.

**Implementation:**

We used a factory to generate various **Card** types (TaskCard, NoteCard, TimerCard) dynamically, based on the item type.

```bash

class CardCreator {
func makeCard(for item: PlanItem) -> CardPresentable {
switch item.kind {
case .focus:   return TaskCard(title: "Focus", subtitle: item.note)
case .study:   return NoteCard(title: "Study", subtitle: item.note)
case .workout: return TimerCard(title: "Workout", subtitle: item.note)
case .breakTime: return NoteCard(title: "Break", subtitle: item.note)
}
}
}

```

This method centralizes product creation and follows the factory structure from the pattern description.

**3. Builder Pattern**

**Purpose:**

Separates the construction of a complex object from its representation.

This pattern allows the same construction process to create different object representations.

**Implementation:**

We used Builder to construct DailyPlan step by step.

Different builder classes generate different plan presets (e.g., “Deep Focus Day”, “Balanced Day”).

```bash

protocol DailyPlanBuilder {
func reset(title: String)
func addFocus(minutes: Int, note: String)
func addWorkout(minutes: Int, note: String)
func build() -> DailyPlan
}

final class DeepFocusPlanBuilder: DailyPlanBuilder {
private var title = ""
private var items: [PlanItem] = []


func reset(title: String) { self.title = title; items.removeAll() }
func addFocus(minutes: Int, note: String) { items.append(.init(kind: .focus, durationMinutes: minutes, note: note)) }
func addWorkout(minutes: Int, note: String) { items.append(.init(kind: .workout, durationMinutes: minutes, note: note)) }
func build() -> DailyPlan { DailyPlan(title: title, items: items) }



}

```

Then, a **Director** decides which steps to execute:

```bash

let director = PlanDirector()
let plan = director.makeDeepFocusDay(with: DeepFocusPlanBuilder())

```
### Not Implemented Patterns just examples.
### **4. Abstract Factory Pattern**

**Purpose:**

Provides an interface for creating **families of related objects** without specifying their concrete classes.

For example, an abstract factory could create consistent sets of UI components for light and dark themes:

```bash

protocol UIFactory {
func createButton() -> Button
func createLabel() -> Label
}

```

Each factory (e.g., DarkUIFactory or LightUIFactory) would generate objects matching that family’s style.
This pattern is useful when the system must support multiple product families.

**5. Prototype Pattern**

**Purpose:**

Creates new objects by **cloning existing ones**, avoiding costly instantiation.

It uses a prototypical instance to copy properties quickly.

**Example:**

```bash

class PlanTemplate: NSCopying {
var name: String
init(name: String) { [self.name](http://self.name/) = name }


func copy(with zone: NSZone? = nil) -> Any {
    return PlanTemplate(name: self.name)
}



}

```

Instead of rebuilding complex objects from scratch, we duplicate an existing “prototype” object.
In a future version of our app, a DailyPlan could be cloned as a starting point for a new plan.

### **Conclusion**

In this laboratory, we successfully implemented **three creational patterns** in Swift:

- **Singleton** for global settings management,
- **Factory Method** for flexible creation of card elements, and
- **Builder** for assembling complete daily plans.

We also discussed **Abstract Factory** and **Prototype** to complete the overview of creational patterns.

These design patterns improve **code reusability, flexibility, and scalability**, making future extensions of the app easier and more maintainable.
