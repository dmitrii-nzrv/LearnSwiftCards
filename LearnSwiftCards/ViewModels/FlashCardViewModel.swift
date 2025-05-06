import Foundation
import SwiftUI

class FlashCardViewModel: ObservableObject {
    @Published var flashCards: [FlashCard]
    @Published var searchText: String = ""
    
    init(flashCards: [FlashCard] = FlashCard.sampleData) {
        self.flashCards = flashCards
    }
    
    // Returns a random card for quiz mode
    func getRandomCard() -> FlashCard? {
        guard !flashCards.isEmpty else { return nil }
        return flashCards.randomElement()
    }
    
    // Returns filtered cards based on search text
    var filteredCards: [FlashCard] {
        if searchText.isEmpty {
            return flashCards
        } else {
            return flashCards.filter { card in
                card.question.localizedCaseInsensitiveContains(searchText) ||
                card.answer.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
} 