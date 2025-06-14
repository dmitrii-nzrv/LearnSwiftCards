import SwiftUI

struct QuestionCell: View {
    let card: FlashCard
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(card.question)
                .font(.chalkHeadline())
                .foregroundStyle(Color(red: 0.2, green: 0.2, blue: 0.3))
            
            Text(card.answer)
                .font(.chalkBody())
                .foregroundStyle(Color(red: 0.3, green: 0.3, blue: 0.4))
        }
        .padding(.vertical, 6)
        .listRowBackground(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(white: 0.92))
                .overlay(
                    // Notebook lines
                    VStack(spacing: 16) {
                        ForEach(0..<5) { _ in
                            Rectangle()
                                .fill(Color.blue.opacity(0.1))
                                .frame(height: 1)
                        }
                    }
                    .padding(.horizontal)
                )
        )
        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    }
} 