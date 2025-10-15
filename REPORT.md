# Laboratory 1. SOLID Principles

Created: October 15, 2025 1:27 PM
Class: TMPS

Crudu Alexandra, FAF-233.

# Purpose

Write an app in which are used 3 SOLID principles.

# Implementation

1. SINGLE RESPONSIBILITY PRINCIPLE (SRP):
Each file/class has ONE responsibility
- FlashcardDataService: Only data management

‘’’ swift

// Services/FlashcardDataService.swift
final class FlashcardDataService {
func getCategories() -> [Category] { /* builds Category/Subcategory trees */ }
}

‘’’

- ShuffleService: Only shuffling, random order

‘’’ swift

// Services/ShuffleService.swift
final class ShuffleService {
func shuffle<T>(_ items: [T]) -> [T] { items.shuffled() }
}

‘’’

- CategoriesViewModel: Only categories state
- GameViewModel: Only game state
- Each view: Single UI responsibility
1. OPEN/CLOSED PRINCIPLE (OCP):
Open for extension, closed for modification. We can add a **new flashcard type** in a new file and the app works without editing GameViewModel or FlashcardView. Then **compose** a new subcategory (only data layer changes):
    - Add new flashcard types by creating new files
    - No need to modify existing code
    - Example: Create HistoryFlashcard.swift conforming to Flashcard

‘’’ swift

// Models/HistoryFlashcard.swift  (new file)
struct HistoryFlashcard: Flashcard {
let id = UUID()
let question: String
let answer: String
}

‘’’

‘’’ swift

// inside FlashcardDataService.getCategories()
Subcategory(name: "World Wars", flashcards: [
HistoryFlashcard(question: "WWII start year?", answer: "1939"),
HistoryFlashcard(question: "D-Day month/year?", answer: "June 1944")
])

‘’’

1. LISKOV SUBSTITUTION PRINCIPLE (LSP):
All flashcard types are interchangeable
    - GameViewModel works with any Flashcard
    - Can substitute any type without breaking code

‘’’ swift

// GameViewModel.swift
@Published var currentFlashcards: [any Flashcard] = [] // works for Geography, Language, Science, History...

‘’’

‘’’ swift

// Models/Flashcard.swift
protocol Flashcard: Identifiable {
var id: UUID { get }
var question: String { get }
var answer: String { get }
}

‘’’

# **Conclusion**

- The project cleanly demonstrates **SRP, OCP, and LSP**: data, shuffling, and screen state are isolated; new card types/subjects are added by composition; and polymorphism lets one ViewModel handle all flashcards.
- The result is **extensible, readable, and test-friendly**: new topics require only new data types and instances, not core logic changes.