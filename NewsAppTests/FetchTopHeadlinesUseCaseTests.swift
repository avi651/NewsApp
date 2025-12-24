//
//  FetchTopHeadlinesUseCaseTests.swift
//  NewsAppTests
//
//  Created by Avinash on 23/12/25.
//

import XCTest
@testable import NewsApp

final class FetchTopHeadlinesUseCaseTests: XCTestCase {
    
    func test_execute_returnArticles() {
        let expectation = expectation(description: "Fetch articles")
        let mockRepo = MockNewsRepository()
        mockRepo.articlesToReturn = [
            Article(title: "Mock News", description: "Mock Desc")
        ]
        let useCase = FetchTopHeadlinesUseCase(repository: mockRepo)
        useCase.execute { articles in
            XCTAssertEqual(articles.count, 1)
            XCTAssertEqual(articles.first?.title, "Mock News")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
