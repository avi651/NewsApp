//
//  DIContainer.swift
//  NewsApp
//
//  Created by Avinash on 25/12/25.
//

import Foundation
import Swinject

final class AppDIContainer {

    static let shared = AppDIContainer()

    let container: Container

    private init() {
        container = Container()
        registerDependencies()
    }

    private func registerDependencies() {

        // MARK: - Network
        container.register(NewsAPIService.self) { _ in
            NewsAPIService() // ✅ default init, arguments nahi
        }

        // MARK: - Repository
        container.register(NewsRepository.self) { resolver in
            NewsRepositoryImpl(
                apiService: resolver.resolve(NewsAPIService.self)!
            )
        }

        // MARK: - UseCases
        container.register(FetchTopHeadlinesUseCase.self) { resolver in
            FetchTopHeadlinesUseCase(
                repository: resolver.resolve(NewsRepository.self)!
            )
        }

        container.register(SearchNewsUseCase.self) { resolver in
            SearchNewsUseCase(
                repository: resolver.resolve(NewsRepository.self)!
            )
        }
    }
}
