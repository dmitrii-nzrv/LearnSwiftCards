//
//  ContentView.swift
//  LearnSwiftCards
//
//  Created by Dmitrii Nazarov on 06.05.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = FlashCardViewModel()
    
    var body: some View {
        TabView {
            QuestionListView(viewModel: viewModel)
                .tabItem {
                    Label("Questions", systemImage: "list.dash")
                }
            
            QuizView(viewModel: viewModel)
                .tabItem {
                    Label("Quiz", systemImage: "questionmark.circle")
                }
        }
    }
}

#Preview {
    ContentView()
}
