//
//  NewsAPIService.swift
//  NewsApp
//
//  Created by Avinash on 24/12/25.
//

import Foundation

final class NewsAPIService {

    func fetchTopHeadlines(
        page: Int,
        completion: @escaping (Result<[Article], Error>) -> Void
    ) {

        let url =
        "https://\(AppConfig.baseURL)/everything?q=technology&page=\(page)&apiKey=\(AppConfig.apiKey)"


        let request = APIRequest(
            url: url,
            method: .get,
            headers: nil,
            body: nil
        )

        NetworkService.shared.request(
            request,
            responseType: NewsResponseDTO.self
        ) { result in
            switch result {
            case .success(let response):
                let articles = response.articles.map {
                    Article(
                        title: $0.title ?? "No Title",
                        description: $0.description ?? ""
                    )
                }
                completion(.success(articles))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func searchNews(
        query: String,
        page: Int,
        completion: @escaping (Result<[Article], Error>) -> Void
    ) {

        let encoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query

        let url =
        "https://\(AppConfig.baseURL)/everything?q=technology&page=\(page)&apiKey=\(AppConfig.apiKey)"

        let request = APIRequest(
            url: url,
            method: .get,
            headers: nil,
            body: nil
        )

        NetworkService.shared.request(
            request,
            responseType: NewsResponseDTO.self
        ) { result in
            switch result {
            case .success(let response):
                let articles = response.articles.map {
                    Article(
                        title: $0.title ?? "No Title",
                        description: $0.description ?? ""
                    )
                }
                completion(.success(articles))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


