import Foundation

// SRP: Responsible ONLY for shuffling logic
class ShuffleService {
    func shuffle<T>(_ items: [T]) -> [T] {
        return items.shuffled()
    }
}
