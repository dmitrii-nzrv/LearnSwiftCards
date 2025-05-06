import SwiftUI

struct QuestionListView: View {
    @ObservedObject var viewModel: FlashCardViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Classroom background
                Color(red: 0.95, green: 0.95, blue: 0.9) // Slight off-white for wall color
                    .ignoresSafeArea()
                
                List {
                    ForEach(viewModel.filteredCards) { card in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(card.question)
                                .font(.custom("Chalkboard SE", size: 18))
                                .fontWeight(.bold)
                                .foregroundStyle(Color(red: 0.2, green: 0.2, blue: 0.3))
                            
                            Text(card.answer)
                                .font(.custom("Chalkboard SE", size: 16))
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
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Questions")
            .toolbarBackground(Color(red: 0.5, green: 0.3, blue: 0.1), for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .searchable(text: $viewModel.searchText, prompt: "Search questions or answers")
            .searchSuggestions {
                Text("SwiftUI").searchCompletion("SwiftUI")
                Text("MVVM").searchCompletion("MVVM")
                Text("Protocol").searchCompletion("protocol")
            }
        }
    }
}

#Preview {
    QuestionListView(viewModel: FlashCardViewModel())
} 