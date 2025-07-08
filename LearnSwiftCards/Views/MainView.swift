//
//  ContentView.swift
//  LearnSwiftCards
//
//  Created by Dmitrii Nazarov on 06.05.2025.
//

import SwiftUI

struct MainView: View {
    // MARK: ~ Properties
    @StateObject private var viewModel = FlashCardViewModel()
    
    // MARK: ~ Body
    var body: some View {
        TabView {
            NavigationStack {
                QuestionListView(viewModel: viewModel)
            }
            .tabItem {
                Label("Questions", systemImage: "list.dash")
            }
            
            NavigationStack {
                QuizView(viewModel: viewModel)
            }
            .tabItem {
                Label("Quiz", systemImage: "questionmark.circle")
            }
        }
        .onAppear {
            // Fix tab bar appearance
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().standardAppearance = tabBarAppearance
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        .accentColor(.brown) // Используем коричневый цвет для выбранных вкладок
    }
}
