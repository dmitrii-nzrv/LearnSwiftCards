import Foundation
import SwiftUI

class FlashCardViewModel: ObservableObject {
    @Published var flashCards: [FlashCard]
    
    init(flashCards: [FlashCard] = FlashCard.sampleData) {
        self.flashCards = flashCards
    }
    
    // Returns a random card for quiz mode
    func getRandomCard() -> FlashCard? {
        guard !flashCards.isEmpty else { return nil }
        return flashCards.randomElement()
    }
} 