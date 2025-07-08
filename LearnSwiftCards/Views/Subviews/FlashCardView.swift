import SwiftUI

// MARK: - FlashCardView
struct FlashCardView: View {
    let card: FlashCard
    @Binding var isFlipped: Bool
    @State private var degrees: Double = 0
    
    var body: some View {
        ZStack {
            // Front side (Question)
            CardSide(content: card.question, backgroundColor: .frontColor, isQuestion: true)
                .rotation3DEffect(
                    .degrees(degrees),
                    axis: (x: 0, y: 1, z: 0),
                    perspective: 0.3
                )
                .opacity(isFlipped ? 0 : 1)
            // Back side (Answer)
            CardSide(content: card.answer, backgroundColor: .backColor, isQuestion: false)
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
        .onChange(of: isFlipped) { oldValue, newValue in
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
}
