//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Avinash on 23/12/25.
//

import Foundation

final class NewsListViewModel: ObservableObject {
    
    // MARK: - UI State
    @Published var articles: [Article] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    
    // MARK: - Pagination
    private var currentPage = 1
    private var isFetching = false
    
    // MARK: - Search
    private var searchTask: DispatchWorkItem?
    private var searchPage = 1
    
    // MARK: - UseCases
    private let fetchTopHeadlinesUseCase: FetchTopHeadlinesUseCase
    private let searchNewsUseCase: SearchNewsUseCase
    
    // MARK: - States
    @Published var state: NewsListViewState = .loading
    
    init(
        fetchTopHeadlinesUseCase: FetchTopHeadlinesUseCase,
        searchNewsUseCase: SearchNewsUseCase
    ) {
        self.fetchTopHeadlinesUseCase = fetchTopHeadlinesUseCase
        self.searchNewsUseCase = searchNewsUseCase
        loadNews()
    }
    
    // MARK: - Top Headlines
    func loadMoreIfNeeded(currentItem: Article) {
        guard let last = articles.last,
              last.id == currentItem.id,
              !isFetching,
              searchText.isEmpty else { return }
        
        currentPage += 1
        loadNews()
    }
    
    func loadNews() {
        isFetching = true
        state = .loading
        
        fetchTopHeadlinesUseCase.execute(page: currentPage) { [weak self] articles in
            DispatchQueue.main.async {
                guard let self else { return }
                
                self.isFetching = false
                
                if articles.isEmpty && self.currentPage == 1 {
                    self.state = .empty
                    self.articles = []
                } else {
                    self.state = .loaded
                    self.articles.append(contentsOf: articles)
                }
            }
        }
    }
    
    // MARK: - Search
    func onSearchTextChanged(_ text: String) {
        searchTask?.cancel()
        searchPage = 1
        
        let task = DispatchWorkItem { [weak self] in
            self?.performSearch(query: text)
        }
        
        searchTask = task
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: task)
    }
    
    private func performSearch(query: String) {
        guard !query.isEmpty else {
            currentPage = 1
            articles.removeAll()
            loadNews()
            return
        }
        
        state = .loading
        searchNewsUseCase.execute(query: query, page: searchPage) { [weak self] results in
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
}
