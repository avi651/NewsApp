//
//  BookmarksViewModel.swift
//  NewsApp
//
//  Created by Avinash on 26/12/25.
//

import Foundation

final class BookmarksViewModel: ObservableObject {

    @Published var articles: [SavedArticleModel] = []

    private let repository: SavedArticlesRepository

    init(repository: SavedArticlesRepository) {
        self.repository = repository
        load()
    }

    func load() {
        let allArticles = repository.fetchAll()

        // ✅ REMOVE DUPLICATES BASED ON ID
        let unique = Dictionary(
            grouping: allArticles,
            by: { $0.id }
        )
        .compactMap { $0.value.first }

        articles = unique
    }

    func delete(at offsets: IndexSet) {
        offsets.forEach { index in
            let article = articles[index]
            repository.delete(id: article.id)
        }
        load()
    }
}

