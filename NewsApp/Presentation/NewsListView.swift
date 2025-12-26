//
//  NewsListView.swift
//  NewsApp
//
//  Created by Avinash on 23/12/25.
//

import SwiftUI

struct NewsListView: View {

    @StateObject private var viewModel: NewsListViewModel

    init(viewModel: NewsListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        content
            .navigationTitle("Top News")
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {

        case .loading:
            ProgressView("Loading...")

        case .empty:
            VStack(spacing: 12) {
                Text("No News Found")
                Button("Retry") {
                    viewModel.loadNews()
                }
            }

        case .error(let message):
            VStack(spacing: 12) {
                Text(message)
                Button("Retry") {
                    viewModel.loadNews()
                }
            }

        case .loaded:
            List(viewModel.articles) { article in
                NewsRowView(
                    article: article,
                    isBookmarked: viewModel.isBookmarked(article),
                    onBookmarkTap: {
                        viewModel.toggleBookmark(article)
                    }
                )
                .onAppear {
                    viewModel.loadMoreIfNeeded(currentItem: article)
                }
            }
        }
    }
}
