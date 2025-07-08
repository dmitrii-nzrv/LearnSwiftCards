import SwiftUI

// MARK: - CardSide
struct CardSide: View {
    let content: String
    let backgroundColor: Color
    let isQuestion: Bool
    
    var body: some View {
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
                Text(isQuestion ? "Question:" : "Answer:")
                    .font(.chalkCaption())
                    .foregroundStyle(Color.white.opacity(0.7))
                    .padding(.bottom, 5)
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