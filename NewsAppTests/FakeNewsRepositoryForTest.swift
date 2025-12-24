//
//  FakeNewsRepositoryForTest.swift
//  NewsAppTests
//
//  Created by Avinash on 23/12/25.
//

import XCTest
@testable import NewsApp

final class MockNewsRepository: NewsRepository {

    var articlesToReturn: [Article] = []

    func fetchTopHeadlines(
        completion: @escaping ([Article]) -> Void
    ) {
        completion(articlesToReturn)
    }
}
