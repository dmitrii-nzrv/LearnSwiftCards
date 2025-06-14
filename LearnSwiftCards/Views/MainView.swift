//
//  ContentView.swift
//  LearnSwiftCards
//
//  Created by Dmitrii Nazarov on 06.05.2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = FlashCardViewModel()
    
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

#Preview {
    MainView()
}
