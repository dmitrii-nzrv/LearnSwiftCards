import SwiftUI

struct FlashCardView: View {
    let card: FlashCard
    @State private var isFlipped = false
    @State private var degrees: Double = 0
    
    var body: some View {
        ZStack {
            // Front side (Question)
            cardSide(content: card.question, backgroundColor: Color.blue.opacity(0.7))
                .rotation3DEffect(.degrees(degrees), axis: (x: 0, y: 1, z: 0))
                .opacity(isFlipped ? 0 : 1)
            
            // Back side (Answer)
            cardSide(content: card.answer, backgroundColor: Color.green.opacity(0.7))
                .rotation3DEffect(.degrees(degrees - 180), axis: (x: 0, y: 1, z: 0))
                .opacity(isFlipped ? 1 : 0)
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.5)) {
                degrees += 180
                isFlipped.toggle()
            }
        }
    }
    
    @ViewBuilder
    private func cardSide(content: String, backgroundColor: Color) -> some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(backgroundColor)
            .overlay(
                Text(content)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(20)
                    .multilineTextAlignment(.center)
            )
            .shadow(radius: 5)
            .padding()
    }
}

#Preview {
    FlashCardView(card: FlashCard.sampleData[0])
} 