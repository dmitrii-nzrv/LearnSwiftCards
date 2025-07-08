import SwiftUI

struct QuestionListView: View {
    // MARK: ~ Properties
    @ObservedObject var viewModel: FlashCardViewModel
    
    // MARK: ~ Body
    var body: some View {
        NavigationStack {
            ZStack {
                // Classroom background
                Color.classroomWall
                    .ignoresSafeArea()
                
                List {
                    ForEach(viewModel.filteredCards) { card in
                        QuestionCell(card: card)
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Questions")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.woodDarkBrown, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .searchable(text: $viewModel.searchText, prompt: "Search questions or answers")
            .onAppear {
                setupWoodNavigationBar()
            }
        }
    }
}

