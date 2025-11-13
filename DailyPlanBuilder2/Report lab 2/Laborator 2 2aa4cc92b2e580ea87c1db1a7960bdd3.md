# Laborator 2


Class: TMPS

### **Laborator 2 – Pattern-uri structurale**

**Disciplina:** TMPS

**Student:** Crudu Alexandra, grupa FAF-233

---

## **1. Noțiuni teoretice – pattern-uri structurale**

- **Adapter** – transformă interfața unei clase (Adaptee) într-o altă interfață (Target) pe care clientul o așteaptă, permițând colaborarea între clase incompatibile.
- **Bridge** – separă o abstracție de implementarea ei, fiecare având propria ierarhie, astfel încât pot evolua independent.
- **Composite** – compune obiecte în structuri de tip arbore (parte-întreg) și permite clientului să trateze uniform atât obiectele individuale, cât și compozițiile lor.
- **Decorator** – atașează responsabilități suplimentare unui obiect în mod dinamic, oferind o alternativă flexibilă la moștenire pentru extinderea funcționalității.
- **Facade** – oferă o interfață unificată și simplificată către un subsistem complex, reducând dependențele dintre client și clasele interne ale subsistemului.
- **Flyweight** – permite partajarea eficientă a unui număr mare de obiecte fine-granulare prin separarea stării intrinseci (partajată) de cea extrinsecă (contextuală).
- **Proxy** – oferă un obiect-înlocuitor care controlează accesul la un alt obiect (real subject), adăugând, de exemplu, lazy loading, caching sau control de acces.

---

## **2. Implementarea pattern-urilor structurale în aplicație**

Aplicația „Daily Plan Builder” folosește trei pattern-uri structurale: **Facade**, **Decorator** și **Adapter**. Clientul unic al sistemului este ContentView.

### **2.1. Facade**

**Rol:** PlanViewModel joacă rolul de Fațadă; el ascunde subsistemele Builder (planuri zilnice), Factory (carduri) și Singleton (setări). ContentView nu cunoaște aceste detalii și lucrează doar cu interfața fațadei.

```bash

// Facade – interfața unică pentru client
protocol PlanningFacade: AnyObject {
func buildDeepFocus()
func buildBalanced()
func toggleTheme()
func setPremium(_ enabled: Bool)
func cards() -> [CardPresentable]
}

// PlanViewModel este Facade
extension PlanViewModel: PlanningFacade {}

```

În aplicație, ContentView primește un PlanViewModel și apelează metodele buildDeepFocus(), buildBalanced(), toggleTheme() și cards(), fără a interacționa direct cu Builder-ele, Factory-ul sau SettingsStore.

### **2.2. Decorator**

**Rol:** pattern-ul Decorator extinde dinamic comportamentul cardurilor atunci când modul Premium este activ. Componentul de bază este CardPresentable, iar decoratoarele adaugă steaua „★” în titlul cardului.

```bash

// Component
protocol CardPresentable {
var title: String { get }
var subtitle: String { get }
}

// Decorator de bază
class CardDecorator: CardPresentable {
private let wrapped: CardPresentable
init(_ wrapped: CardPresentable) { self.wrapped = wrapped }
var title: String { wrapped.title }
var subtitle: String { wrapped.subtitle }
}

// Concrete Decorator
final class StarredCardDecorator: CardDecorator {
override var title: String { "★ " + super.title }
}

```

Factory-ul pentru carduri premium folosește Decoratorul:

```bash

final class PremiumCardCreator: CardCreator {
override func makeCard(for item: PlanItem) -> CardPresentable {
let base = super.makeCard(for: item)         // ConcreteComponent
return StarredCardDecorator(base)            // Decorator
}
}

```

Astfel, când modul Premium este activ, cardurile afișate în UI sunt decorate cu ★ fără a modifica structurile TaskCard, NoteCard sau TimerCard.

### **2.3. Adapter**

**Rol:** pattern-ul Adapter permite integrarea unui format „legacy” de task (LegacyTaskDTO) cu sistemul intern bazat pe PlanItem. Clientul așteaptă un PlanItemConvertible (Target), iar LegacyTaskAdapter adaptează LegacyTaskDTO (Adaptee) la acest Target.

```bash

// Adaptee – format vechi
struct LegacyTaskDTO {
let categoryCode: String  // "F", "S", "W", "B"
let duration: Int
let note: String
}

// Target
protocol PlanItemConvertible {
func toPlanItem() -> PlanItem
}

// Adapter – compoziție cu Adaptee
struct LegacyTaskAdapter: PlanItemConvertible {
let legacy: LegacyTaskDTO

func toPlanItem() -> PlanItem {
    let kind: PlanItemKind = switch legacy.categoryCode {
    case "F": .focus
    case "S": .study
    case "W": .workout
    case "B": .breakTime
    default:  .focus
    }
    return PlanItem(kind: kind,
                    durationMinutes: legacy.duration,
                    note: legacy.note)
}
}

```

PlanViewModel utilizează Adapterul printr-o metodă de import:

```bash

func importLegacySampleTask() {
let legacy = LegacyTaskDTO(categoryCode: "F", duration: 25, note: "Legacy focus task")
let adapter = LegacyTaskAdapter(legacy: legacy)
plan.items.append(adapter.toPlanItem())
}

```

În acest fel, structura GoF este respectată: PlanViewModel este Clientul, PlanItemConvertible este Target, LegacyTaskDTO este Adaptee, iar LegacyTaskAdapter este Adapterul bazat pe compoziție.

## **3. Concluzie**

În acest laborator au fost studiate pattern-urile structurale din catalogul GoF și au fost implementate trei dintre ele în aplicația „Daily Plan Builder”: **Facade**, **Decorator** și **Adapter**. Fațada (PlanViewModel) oferă un punct unic de acces pentru UI, ascunzând subsistemele de construcție și configurare a planurilor. Decoratorul (StarredCardDecorator) extinde dinamic comportamentul cardurilor premium fără a modifica clasele existente, iar Adapterul (LegacyTaskAdapter) permite integrarea unui format vechi de date în modelul intern al aplicației. Utilizarea acestor pattern-uri îmbunătățește modularitatea, lizibilitatea și posibilitatea de extindere a sistemului.
