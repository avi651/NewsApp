//
//  NewsAPIService.swift
//  NewsApp
//
//  Created by Avinash on 24/12/25.
//

import Foundation

final class NewsAPIService {

    private let apiKey = "85a2c98d226a4365ac892854e30287d7"

    func fetchTopHeadlines(
        page: Int,
        completion: @escaping (Result<[Article], Error>) -> Void
    ) {

        let url =
        "https://newsapi.org/v2/everything?q=technology&page=\(page)&apiKey=\(apiKey)"

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
        "https://newsapi.org/v2/everything?q=\(encoded)&page=\(page)&apiKey=\(apiKey)"

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


