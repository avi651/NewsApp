//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by Avinash on 23/12/25.
//

import SwiftUI

@main
struct NewsAppApp: App {
    var body: some Scene {
        WindowGroup {

            let apiService = NewsAPIService()
            let repository = NewsRepositoryImpl(apiService: apiService)

            let fetchTopHeadlinesUseCase =
                FetchTopHeadlinesUseCase(repository: repository)

            let searchNewsUseCase =
                SearchNewsUseCase(repository: repository)

            let viewModel = NewsListViewModel(
                fetchTopHeadlinesUseCase: fetchTopHeadlinesUseCase,
                searchNewsUseCase: searchNewsUseCase
            )

            NewsListView(viewModel: viewModel)
        }
    }
}
