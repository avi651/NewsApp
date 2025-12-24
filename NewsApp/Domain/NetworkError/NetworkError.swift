//
//  NetworkError.swift
//  NewsApp
//
//  Created by Avinash on 24/12/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)
}
