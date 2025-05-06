import SwiftUI

struct FlashCardView: View {
    let card: FlashCard
    @State private var isFlipped = false
    @State private var degrees: Double = 0
    
    // Random chalkboard colors
    private let chalkboardColors: [Color] = [
        Color(red: 0.1, green: 0.2, blue: 0.1), // Dark green
        Color(red: 0.05, green: 0.05, blue: 0.2), // Dark blue
        Color(red: 0.2, green: 0.1, blue: 0.1), // Dark red
        Color(red: 0.1, green: 0.1, blue: 0.1), // Classic black
    ]
    
    // Generate a random color for this card
    private var frontColor: Color {
        chalkboardColors.randomElement() ?? Color(red: 0.1, green: 0.1, blue: 0.1)
    }
    
    private var backColor: Color {
        chalkboardColors.randomElement() ?? Color(red: 0.1, green: 0.1, blue: 0.1)
    }
    
    var body: some View {
        ZStack {
            // Front side (Question)
            cardSide(content: card.question, backgroundColor: frontColor, isQuestion: true)
                .rotation3DEffect(
                    .degrees(degrees),
                    axis: (x: 0, y: 1, z: 0),
                    perspective: 0.3
                )
                .opacity(isFlipped ? 0 : 1)
            
            // Back side (Answer)
            cardSide(content: card.answer, backgroundColor: backColor, isQuestion: false)
                .rotation3DEffect(
                    .degrees(degrees - 180),
                    axis: (x: 0, y: 1, z: 0),
                    perspective: 0.3
                )
                .opacity(isFlipped ? 1 : 0)
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                degrees += 180
                isFlipped.toggle()
            }
        }
    }
    
    @ViewBuilder
    private func cardSide(content: String, backgroundColor: Color, isQuestion: Bool) -> some View {
        ZStack {
            // Chalkboard background
            RoundedRectangle(cornerRadius: 12)
                .fill(backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.3), lineWidth: 2)
                )
                .overlay(
                    // Chalk dust effect
                    ZStack {
                        ForEach(0..<20) { _ in
                            Circle()
                                .fill(Color.white.opacity(Double.random(in: 0.05...0.15)))
                                .frame(width: Double.random(in: 1...3), height: Double.random(in: 1...3))
                                .position(
                                    x: Double.random(in: 20...300),
                                    y: Double.random(in: 20...200)
                                )
                        }
                    }
                )
                .shadow(radius: 5)
            
            VStack {
                if isQuestion {
                    Text("Question:")
                        .font(.custom("Chalkboard SE", size: 16))
                        .foregroundStyle(Color.white.opacity(0.7))
                        .padding(.bottom, 5)
                } else {
                    Text("Answer:")
                        .font(.custom("Chalkboard SE", size: 16))
                        .foregroundStyle(Color.white.opacity(0.7))
                        .padding(.bottom, 5)
                }
                
                Text(content)
                    .font(.custom("Chalkboard SE", size: 22))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .shadow(color: .white.opacity(0.5), radius: 1, x: 0.5, y: 0.5)
            }
            .padding(20)
            
            // Wooden frame border
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(red: 0.6, green: 0.4, blue: 0.2), lineWidth: 8)
                .shadow(radius: 2)
        }
        .padding()
    }
}

#Preview {
    FlashCardView(card: FlashCard.sampleData[0])
} 