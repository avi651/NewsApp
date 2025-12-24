//
//  NewsRepositoryImpl.swift
//  NewsApp
//
//  Created by Avinash on 24/12/25.
//

import Foundation

final class NewsRepositoryImpl: NewsRepository {
    
    private let apiService: NewsAPIService
    
    init(apiService: NewsAPIService) {
        self.apiService = apiService
    }
    
    func fetchTopHeadlines(
        page: Int,
        completion: @escaping ([Article]) -> Void
    ) {
        apiService.fetchTopHeadlines(page: page) { result in
            switch result {
            case .success(let articles):
                completion(articles)
            case .failure:
                completion([])
            }
        }
    }
    
    func search(query: String, page: Int, completion: @escaping ([Article]) -> Void) {
        apiService.searchNews(query: query, page: page) { result in
            switch result {
            case .success(let articles):
                completion(articles)
            case .failure:
                completion([])
            }
        }
    }
}
