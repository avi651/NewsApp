//
//  SearchNewsUseCase.swift
//  NewsApp
//
//  Created by Avinash on 24/12/25.
//

import Foundation

final class SearchNewsUseCase {
    private let repository: NewsRepository
    init(repository: NewsRepository) { self.repository = repository }
    func execute(
        query: String,
        page: Int,
        completion: @escaping ([Article]) -> Void
    ) {
        repository.search(query: query, page: page, completion: completion)
    }
}
