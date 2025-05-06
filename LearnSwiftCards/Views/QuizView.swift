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
                        
                        Button(action: {
                            // Reset flip state and get new card
                            isCardFlipped = false
                            
                            // Small delay to ensure animation completes
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                currentCard = viewModel.getRandomCard()
                            }
                        }) {
                            Text("Next Card")
                                .woodButtonStyle()
                        }
                        .padding()
                    } else {
                        VStack(spacing: 20) {
                            Text("No cards available")
                                .font(.chalkTitle())
                                .foregroundStyle(Color(red: 0.3, green: 0.3, blue: 0.3))
                            
                            Button(action: {
                                isCardFlipped = false
                                currentCard = viewModel.getRandomCard()
                            }) {
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
                Rectangle()
                    .fill(Color.woodBrown)
                    .frame(height: 60)
                    .overlay(
                        Rectangle()
                            .fill(Color(red: 0.65, green: 0.45, blue: 0.25))
                            .frame(height: 5)
                            .offset(y: -20)
                    )
                    .overlay(
                        // Wood grain
                        ForEach(0..<5) { i in
                            Path { path in
                                path.move(to: CGPoint(x: 0, y: CGFloat(i) * 12))
                                path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: CGFloat(i) * 12 + 5))
                            }
                            .stroke(Color(red: 0.55, green: 0.35, blue: 0.15), lineWidth: 0.5)
                        }
                    )
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
}

#Preview {
    QuizView(viewModel: FlashCardViewModel())
} 