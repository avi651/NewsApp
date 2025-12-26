//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Avinash on 23/12/25.
//

import Foundation
import Combine

final class NewsListViewModel: ObservableObject {

    // MARK: - UI State
    @Published var articles: [Article] = []
    @Published var state: NewsListViewState = .loading
    @Published var searchText: String = ""

    // MARK: - Pagination
    private var currentPage = 1
    private var isFetching = false

    // MARK: - UseCases
    private let fetchTopHeadlinesUseCase: FetchTopHeadlinesUseCase
    private let searchNewsUseCase: SearchNewsUseCase
    private let savedRepository: SavedArticlesRepository

    // MARK: - Combine
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init
    init(
        fetchTopHeadlinesUseCase: FetchTopHeadlinesUseCase,
        searchNewsUseCase: SearchNewsUseCase,
        savedRepository: SavedArticlesRepository
    ) {
        self.fetchTopHeadlinesUseCase = fetchTopHeadlinesUseCase
        self.searchNewsUseCase = searchNewsUseCase
        self.savedRepository = savedRepository

        bindSearch()
        loadNews()
    }

    // MARK: - Search (Combine)
    private func bindSearch() {
        $searchText
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
                self?.handleSearch(text)
            }
            .store(in: &cancellables)
    }

    private func handleSearch(_ text: String) {
        guard !text.isEmpty else {
            currentPage = 1
            articles.removeAll()
            loadNews()
            return
        }

        state = .loading

        searchNewsUseCase.execute(query: text, page: 1) { [weak self] results in
            DispatchQueue.main.async {
                guard let self else { return }

                if results.isEmpty {
                    self.state = .empty
                    self.articles = []
                } else {
                    self.state = .loaded
                    self.articles = results
                }
            }
        }
    }

    // MARK: - Bookmark
    func isBookmarked(_ article: Article) -> Bool {
        savedRepository.isSaved(id: article.id)
    }

    func toggleBookmark(_ article: Article) {

        if isBookmarked(article) {
            savedRepository.delete(id: article.id)
        } else {
            ImageDownloader.shared.download(from: article.imageUrl ?? "") { data in
                let saved = SavedArticleModel(
                    id: article.id,
                    title: article.title,
                    desc: article.description,
                    url: article.url,
                    imageData: data,
                    savedAt: Date()
                )
                self.savedRepository.save(saved)
            }
        }

        // Force SwiftUI refresh (Combine-friendly)
        articles = articles.map { $0 }
    }

    // MARK: - Pagination
    func loadMoreIfNeeded(currentItem: Article) {
        guard let last = articles.last,
              last.id == currentItem.id,
              !isFetching,
              searchText.isEmpty else { return }

        currentPage += 1
        loadNews()
    }

    // MARK: - Load News
    func loadNews() {
        isFetching = true
        state = .loading

        fetchTopHeadlinesUseCase.execute(page: currentPage) { [weak self] newArticles in
            DispatchQueue.main.async {
                guard let self else { return }
                self.isFetching = false

                if newArticles.isEmpty && self.currentPage == 1 {
                    self.state = .empty
                    self.articles = []
                } else {
                    self.state = .loaded
                    let existingIDs = Set(self.articles.map { $0.url })
                    let filtered = newArticles.filter { !existingIDs.contains($0.url) }
                    self.articles.append(contentsOf: filtered)

                }
            }
        }
    }
}
