//
//  DIContainer.swift
//  NewsApp
//
//  Created by Avinash on 25/12/25.
//

import Foundation
import Swinject

public final class AppDIContainer {
    
    static let shared = AppDIContainer()
    
    let container: Container
    
    private init() {
        container = Container()
        registerDependencies()
    }
    
    private func registerDependencies() {
        
        // MARK: - Network
        container.register(NewsAPIService.self) { _ in
            NewsAPIService()
        }
        
        // MARK: - Core Data
        container.register(PersistenceController.self) { _ in
            PersistenceController.shared
        }
        .inObjectScope(.container)
        
        // MARK: - Repository (API)
        container.register(NewsRepository.self) { resolver in
            NewsRepositoryImpl(
                apiService: resolver.resolve(NewsAPIService.self)!
            )
        }
        
        // MARK: - Repository (Saved / Core Data)
        container.register(SavedArticlesRepository.self) { resolver in
            SavedArticlesRepositoryImpl(
                persistence: resolver.resolve(PersistenceController.self)!
            )
        }
        .inObjectScope(.container)
        
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
        
        // MARK: - ViewModels
        
        container.register(NewsListViewModel.self) { resolver in
            NewsListViewModel(
                fetchTopHeadlinesUseCase: resolver.resolve(FetchTopHeadlinesUseCase.self)!,
                searchNewsUseCase: resolver.resolve(SearchNewsUseCase.self)!,
                savedRepository: resolver.resolve(SavedArticlesRepository.self)!
            )
        }
        
        // 🔖 FIX: BookmarksViewModel REGISTERED
        container.register(BookmarksViewModel.self) { resolver in
            BookmarksViewModel(
                repository: resolver.resolve(SavedArticlesRepository.self)!
            )
        }
    }
}
