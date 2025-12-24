//
//  NetworkService.swift
//  NewsApp
//
//  Created by Avinash on 24/12/25.
//

import Foundation

final class NetworkService {

    static let shared = NetworkService()
    private init() {}

    func request<T: Decodable>(
        _ request: APIRequest,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {

        guard let url = URL(string: request.url) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body

        request.headers?.forEach {
            urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
        }

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            if let httpResponse = response as? HTTPURLResponse,
               !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(NetworkError.serverError(statusCode: httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(NetworkError.decodingError))
            }

        }.resume()
    }
}

