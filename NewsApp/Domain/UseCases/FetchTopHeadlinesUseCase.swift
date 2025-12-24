//
//  FetchTopHeadlinesUseCase.swift
//  NewsApp
//
//  Created by Avinash on 23/12/25.
//

import Foundation

final class FetchTopHeadlinesUseCase {
    private let repository: NewsRepository
    
    init(repository: NewsRepository) {
        self.repository = repository
    }
    
    func execute(page: Int, completion: @escaping ([Article]) -> Void) {
        repository.fetchTopHeadlines(page: page, completion: completion)
    }
}
