//
//  NewsListView.swift
//  NewsApp
//
//  Created by Avinash on 23/12/25.
//

import SwiftUI

struct NewsListView: View {
    
    @StateObject private var articleViewModel: NewsListViewModel
    
    init(viewModel: NewsListViewModel) {
        _articleViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Top News")
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch articleViewModel.state {
            
        case .loading:
            ProgressView("Loading...")
            
        case .empty:
            VStack(spacing: 12) {
                Text("No News Found")
                Button("Retry") {
                    articleViewModel.loadNews()
                }
            }
            
        case .error(let message):
            VStack(spacing: 12) {
                Text(message)
                Button("Retry") {
                    articleViewModel.loadNews()
                }
            }
            
        case .loaded:
            List(articleViewModel.articles) { article in
                VStack(alignment: .leading) {
                    Text(article.title).font(.headline)
                    Text(article.description).font(.subheadline)
                }
            }
        }
    }
}
