import SwiftUI

struct QuestionListView: View {
    @ObservedObject var viewModel: FlashCardViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.filteredCards) { card in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(card.question)
                            .font(.headline)
                        Text(card.answer)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Questions")
            .searchable(text: $viewModel.searchText, prompt: "Search questions or answers")
        }
    }
}

#Preview {
    QuestionListView(viewModel: FlashCardViewModel())
} 