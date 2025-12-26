//
//  Article.swift
//  NewsApp
//
//  Created by Avinash on 23/12/25.
//

import Foundation

struct Article: Identifiable, Hashable {
    let id: String
    let title: String
    let description: String
    let url: String
    let imageUrl: String?
}

extension Article {
    init(dto: ArticleDTO) {
        self.url = dto.url ?? UUID().uuidString
        self.id = "\(dto.url ?? UUID().uuidString)-\(UUID().uuidString)"
        self.title = dto.title ?? "No title"
        self.description = dto.description ?? ""
        self.imageUrl = dto.urlToImage
    }
}
