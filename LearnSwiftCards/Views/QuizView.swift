import SwiftUI

struct QuizView: View {
    @ObservedObject var viewModel: FlashCardViewModel
    @State private var currentCard: FlashCard?
    @State private var showingAnswer = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Classroom background
                Color.classroomWall
                    .ignoresSafeArea()
                
                // Wooden desk texture at the bottom
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(Color.woodBrown)
                        .frame(height: 100)
                        .overlay(
                            Rectangle()
                                .fill(Color(red: 0.65, green: 0.45, blue: 0.25))
                                .frame(height: 5)
                                .offset(y: -40)
                        )
                        .overlay(
                            // Wood grain
                            ForEach(0..<8) { i in
                                Path { path in
                                    path.move(to: CGPoint(x: 0, y: CGFloat(i) * 12))
                                    path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: CGFloat(i) * 12 + 5))
                                }
                                .stroke(Color(red: 0.55, green: 0.35, blue: 0.15), lineWidth: 0.5)
                            }
                        )
                }
                .ignoresSafeArea()
                
                VStack {
                    if let card = currentCard {
                        FlashCardView(card: card)
                            .frame(height: 400)
                        
                        Button(action: {
                            showingAnswer = false
                            currentCard = viewModel.getRandomCard()
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
}

#Preview {
    QuizView(viewModel: FlashCardViewModel())
} 