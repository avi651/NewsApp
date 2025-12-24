//
//  NewsDTO.swift
//  NewsApp
//
//  Created by Avinash on 24/12/25.
//

import Foundation

struct NewsResponseDTO: Codable {
    let articles: [ArticleDTO]
}

struct ArticleDTO: Codable {
    let title: String?
    let description: String?
}
