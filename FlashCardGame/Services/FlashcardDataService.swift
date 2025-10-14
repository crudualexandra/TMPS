import Foundation

// SRP: Responsible ONLY for managing flashcard data
class FlashcardDataService {
    func getCategories() -> [Category] {
        return [
            Category(
                name: "Geography",
                icon: "globe.europe.africa.fill",
                subcategories: [
                    Subcategory(
                        name: "Capitals",
                        flashcards: createCapitalsFlashcards()
                    ),
                    Subcategory(
                        name: "Flags",
                        flashcards: createFlagsFlashcards()
                    )
                ]
            ),
            Category(
                name: "Languages",
                icon: "textbook.fill",
                subcategories: [
                    Subcategory(
                        name: "Spanish Basics",
                        flashcards: createSpanishFlashcards()
                    )
                ]
            ),
            Category(
                name: "Science",
                icon: "flask.fill",
                subcategories: [
                    Subcategory(
                        name: "Elements",
                        flashcards: createElementsFlashcards()
                    )
                ]
            )
        ]
    }
    
    private func createCapitalsFlashcards() -> [GeographyFlashcard] {
        return [
            GeographyFlashcard(question: "Moldova", answer: "Chișinău"),
            GeographyFlashcard(question: "France", answer: "Paris"),
            GeographyFlashcard(question: "Germany", answer: "Berlin"),
            GeographyFlashcard(question: "Italy", answer: "Rome"),
            GeographyFlashcard(question: "Spain", answer: "Madrid"),
            GeographyFlashcard(question: "Portugal", answer: "Lisbon"),
            GeographyFlashcard(question: "Romania", answer: "Bucharest"),
            GeographyFlashcard(question: "Poland", answer: "Warsaw"),
            GeographyFlashcard(question: "Japan", answer: "Tokyo"),
            GeographyFlashcard(question: "Australia", answer: "Canberra")
        ]
    }
    
    private func createFlagsFlashcards() -> [GeographyFlashcard] {
        return [
            GeographyFlashcard(question: "🇲🇩", answer: "Moldova"),
            GeographyFlashcard(question: "🇫🇷", answer: "France"),
            GeographyFlashcard(question: "🇩🇪", answer: "Germany"),
            GeographyFlashcard(question: "🇮🇹", answer: "Italy"),
            GeographyFlashcard(question: "🇪🇸", answer: "Spain")
        ]
    }
    
    private func createSpanishFlashcards() -> [LanguageFlashcard] {
        return [
            LanguageFlashcard(question: "Hello", answer: "Hola"),
            LanguageFlashcard(question: "Goodbye", answer: "Adiós"),
            LanguageFlashcard(question: "Thank you", answer: "Gracias"),
            LanguageFlashcard(question: "Please", answer: "Por favor"),
            LanguageFlashcard(question: "Yes", answer: "Sí")
        ]
    }
    
    private func createElementsFlashcards() -> [ScienceFlashcard] {
        return [
            ScienceFlashcard(question: "H", answer: "Hydrogen"),
            ScienceFlashcard(question: "He", answer: "Helium"),
            ScienceFlashcard(question: "O", answer: "Oxygen"),
            ScienceFlashcard(question: "C", answer: "Carbon"),
            ScienceFlashcard(question: "N", answer: "Nitrogen")
        ]
    }
}
