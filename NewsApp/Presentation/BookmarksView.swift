//
//  BookmarksView.swift
//  NewsApp
//
//  Created by Avinash on 25/12/25.
//

import SwiftUI

struct BookmarksView: View {

    @StateObject private var viewModel: BookmarksViewModel

    init(viewModel: BookmarksViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Group {
            if viewModel.articles.isEmpty {
                Text("No Bookmarks")
                    .foregroundColor(.secondary)
            } else {
                List {
                    ForEach(viewModel.articles) { article in
                        BookmarkRowView(article: article)
                    }
                    .onDelete(perform: viewModel.delete)
                }
            }
        }
        .navigationTitle("Saved")
        .onAppear {
            viewModel.load()
        }
    }
}
