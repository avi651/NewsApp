//
//  BookmarkIntegrationTests.swift
//  NewsAppTests
//
//  Created by Avinash on 26/12/25.
//

import XCTest
@testable import NewsApp

final class BookmarkIntegrationTests: XCTestCase {

    private var repository: SavedArticlesRepository!
    private var fetchUseCase: FetchTopHeadlinesUseCase!

    override func setUp() {
        super.setUp()

        // REAL CORE DATA (in‑memory recommended)
        let persistence = PersistenceController(inMemory: true)
        repository = SavedArticlesRepositoryImpl(persistence: persistence)

        let apiService = NewsAPIService()
        let newsRepo = NewsRepositoryImpl(apiService: apiService)
        fetchUseCase = FetchTopHeadlinesUseCase(repository: newsRepo)
    }

    func test_bookmark_flow_with_real_api() {

        let expectation = XCTestExpectation(description: "Bookmark flow")

        fetchUseCase.execute(page: 1) { articles in
            guard let article = articles.first else {
                XCTFail("No article received")
                return
            }

            // SAVE
            let saved = SavedArticleModel(
                id: article.id,
                title: article.title,
                desc: article.description,
                url: article.url,
                imageData: nil,
                savedAt: Date()
            )

            self.repository.save(saved)

            // VERIFY
            let savedItems = self.repository.fetchAll()
            XCTAssertEqual(savedItems.count, 1)
            XCTAssertEqual(savedItems.first?.id, article.id)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10)
    }
}
