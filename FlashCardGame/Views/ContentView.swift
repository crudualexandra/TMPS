import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CategoriesViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(viewModel.categories) { category in
                        CategoryCardView(category: category)
                    }
                }
                .padding()
            }
            .navigationTitle("Flashcard Game")
            .background(Color(.systemGroupedBackground))
        }
    }
}
