import SwiftUI

struct QuizView: View {
    @ObservedObject var viewModel: FlashCardViewModel
    @State private var currentCard: FlashCard?
    @State private var showingAnswer = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if let card = currentCard {
                    FlashCardView(card: card)
                        .frame(height: 400)
                    
                    Button("Next Card") {
                        showingAnswer = false
                        currentCard = viewModel.getRandomCard()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                } else {
                    Text("No cards available")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    
                    Button("Start Quiz") {
                        currentCard = viewModel.getRandomCard()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
            }
            .navigationTitle("Quiz Mode")
            .onAppear {
                if currentCard == nil {
                    currentCard = viewModel.getRandomCard()
                }
            }
        }
    }
}

#Preview {
    QuizView(viewModel: FlashCardViewModel())
} 