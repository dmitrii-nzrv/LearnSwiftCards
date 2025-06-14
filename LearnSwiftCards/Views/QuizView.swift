import SwiftUI

struct QuizView: View {
    @ObservedObject var viewModel: FlashCardViewModel
    @State private var currentCard: FlashCard?
    @State private var isCardFlipped = false
    
    var body: some View {
        ZStack {
            // Classroom background
            Color.classroomWall
                .ignoresSafeArea()
            
            // Content with wooden desk but respecting TabBar
            VStack(spacing: 0) {
                // Main content area
                VStack {
                    if let card = currentCard {
                        FlashCardView(card: card, isFlipped: $isCardFlipped)
                            .frame(height: 350)
                        
                        Button(action: nextCard) {
                            Text("Next Card")
                                .woodButtonStyle()
                        }
                        .padding()
                    } else {
                        VStack(spacing: 20) {
                            Text("No cards available")
                                .font(.chalkTitle())
                                .foregroundStyle(Color(red: 0.3, green: 0.3, blue: 0.3))
                            
                            Button(action: startQuiz) {
                                Text("Start Quiz")
                                    .woodButtonStyle()
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.8))
                                .shadow(radius: 5)
                        )
                    }
                }
                .padding(.bottom, 10)
                
                Spacer()
                
                // Wooden desk above TabBar
                WoodenSurface()
                    .padding(.bottom, 55) // Padding for TabBar height
            }
        }
        .navigationTitle("Quiz Mode")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.woodDarkBrown, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .onAppear {
            setupWoodNavigationBar()
            if currentCard == nil {
                currentCard = viewModel.getRandomCard()
            }
        }
    }
    
    private func nextCard() {
        isCardFlipped = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            currentCard = viewModel.getRandomCard()
        }
    }
    
    private func startQuiz() {
        isCardFlipped = false
        currentCard = viewModel.getRandomCard()
    }
}

#Preview {
    QuizView(viewModel: FlashCardViewModel())
} 