import SwiftUI

struct CategoryCardView: View {
    let category: Category
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: category.icon)
                    .font(.title)
                    .foregroundColor(.white)
                Text(category.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            
            ForEach(category.subcategories) { subcategory in
                NavigationLink(destination: GameView(subcategory: subcategory)) {
                    HStack {
                        Text(subcategory.name)
                            .foregroundColor(.white)
                        Spacer()
                        Text("\(subcategory.flashcards.count) cards")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white.opacity(0.6))
                    }
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                }
            }
        }
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}
