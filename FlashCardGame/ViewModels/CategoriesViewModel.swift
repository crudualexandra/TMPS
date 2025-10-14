import Foundation
import Combine

// SRP: Manages state for the main categories view
class CategoriesViewModel: ObservableObject {
    @Published var categories: [Category] = []
    private let dataService: FlashcardDataService
    
    init(dataService: FlashcardDataService = FlashcardDataService()) {
        self.dataService = dataService
        loadCategories()
    }
    
    func loadCategories() {
        categories = dataService.getCategories()
    }
}
