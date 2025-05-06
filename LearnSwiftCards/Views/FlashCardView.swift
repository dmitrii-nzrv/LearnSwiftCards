import SwiftUI

struct FlashCardView: View {
    let card: FlashCard
    @Binding var isFlipped: Bool
    @State private var degrees: Double = 0
    
    // For backward compatibility with preview and non-controlled usage
    init(card: FlashCard, isFlipped: Binding<Bool>? = nil) {
        self.card = card
        self._isFlipped = isFlipped ?? .constant(false)
    }
    
    // Random colors for front and back
    private var frontColor: Color {
        [Color.chalkboardGreen, Color.chalkboardBlue, 
         Color.chalkboardRed, Color.chalkboardBlack].randomElement()!
    }
    
    private var backColor: Color {
        [Color.chalkboardGreen, Color.chalkboardBlue, 
         Color.chalkboardRed, Color.chalkboardBlack].randomElement()!
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
        .onChange(of: isFlipped) { newValue in
            // Update degrees when flipped state changes externally
            if newValue && degrees.truncatingRemainder(dividingBy: 360) == 0 {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    degrees += 180
                }
            } else if !newValue && degrees.truncatingRemainder(dividingBy: 360) == 180 {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    degrees += 180
                }
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
                        .font(.chalkCaption())
                        .foregroundStyle(Color.white.opacity(0.7))
                        .padding(.bottom, 5)
                } else {
                    Text("Answer:")
                        .font(.chalkCaption())
                        .foregroundStyle(Color.white.opacity(0.7))
                        .padding(.bottom, 5)
                }
                
                Text(content)
                    .font(.chalkHeadline())
                    .foregroundStyle(Color.chalkWhite)
                    .multilineTextAlignment(.center)
                    .shadow(color: .white.opacity(0.5), radius: 1, x: 0.5, y: 0.5)
            }
            .padding(20)
            
            // Wooden frame border
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.woodBrown, lineWidth: 8)
                .shadow(radius: 2)
        }
        .padding()
    }
}

#Preview {
    FlashCardView(card: FlashCard.sampleData[0])
} 