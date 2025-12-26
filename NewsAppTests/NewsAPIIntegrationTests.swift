//
//  NewsAPIIntegrationTests.swift
//  NewsAppTests
//
//  Created by Avinash on 26/12/25.
//

import XCTest
@testable import NewsApp

final class NewsAPIIntegrationTests: XCTestCase {

    private var fetchUseCase: FetchTopHeadlinesUseCase!

    override func setUp() {
        super.setUp()

        // REAL OBJECTS (NO MOCKS)
        let apiService = NewsAPIService()
        let repository = NewsRepositoryImpl(apiService: apiService)
        fetchUseCase = FetchTopHeadlinesUseCase(repository: repository)
    }

    override func tearDown() {
        fetchUseCase = nil
        super.tearDown()
    }

    func test_fetchTopHeadlines_fromRealAPI() {

        let expectation = XCTestExpectation(description: "Fetch real news from API")

        fetchUseCase.execute(page: 1) { articles in

            // ✅ BASIC ASSERTIONS
            XCTAssertFalse(articles.isEmpty, "Articles should not be empty")

            let first = articles.first
            XCTAssertNotNil(first)
            XCTAssertFalse(first?.title.isEmpty ?? true)
            XCTAssertFalse(first?.url.isEmpty ?? true)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 15)
    }
}
