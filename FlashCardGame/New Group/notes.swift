// ============================================================
// SOLID PRINCIPLES SUMMARY
// ============================================================
/*
 1. SINGLE RESPONSIBILITY PRINCIPLE (SRP):
    Each file/class has ONE responsibility
    - FlashcardDataService: Only data management
    - ShuffleService: Only shuffling
    - CategoriesViewModel: Only categories state
    - GameViewModel: Only game state
    - Each view: Single UI responsibility
 
 2. OPEN/CLOSED PRINCIPLE (OCP):
     Open for extension, closed for modification
    - Add new flashcard types by creating new files
    - No need to modify existing code
    - Example: Create HistoryFlashcard.swift conforming to Flashcard
 
 3. LISKOV SUBSTITUTION PRINCIPLE (LSP):
     All flashcard types are interchangeable
    - GameViewModel works with any Flashcard
    - Can substitute any type without breaking code
 */
