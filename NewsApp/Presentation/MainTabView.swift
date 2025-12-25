//
//  MainTabView.swift
//  NewsApp
//
//  Created by Avinash on 25/12/25.
//

import SwiftUI

struct MainTabView: View {
    let di: AppDIContainer
    var body: some View {
        TabView {
            NavigationStack {
                NewsListView(
                    viewModel: NewsListViewModel(
                        fetchTopHeadlinesUseCase: di.container.resolve(FetchTopHeadlinesUseCase.self)!,
                        searchNewsUseCase: di.container.resolve(SearchNewsUseCase.self)!
                    )
                )
            }.tabItem {
                Label("News", systemImage: "newspaper")
            }
            
            // 🔍 SEARCH TAB
            NavigationStack {
                SearchView()
            }
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
            
            // 🔖 SAVED TAB
            NavigationStack {
                BookmarksView()
            }
            .tabItem {
                Label("Saved", systemImage: "bookmark")
            }
        }
    }
}

//#Preview {
//    MainTabView()
//}
