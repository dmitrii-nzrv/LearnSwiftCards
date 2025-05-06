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
                .toolbarBackground(.visible, for: .tabBar)
            
            QuizView(viewModel: viewModel)
                .tabItem {
                    Label("Quiz", systemImage: "questionmark.circle")
                }
        }
        .onAppear {
            // Set tab bar appearance to look like wood
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(Color.woodBrown)
            
            // Set the tab bar item colors
            appearance.stackedLayoutAppearance.normal.iconColor = .white
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor(red: 1.0, green: 0.9, blue: 0.7, alpha: 1.0)
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(red: 1.0, green: 0.9, blue: 0.7, alpha: 1.0)]
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

#Preview {
    ContentView()
}
