//
//  SavedArticlesRepository.swift
//  NewsApp
//
//  Created by Avinash on 26/12/25.
//

import Foundation

protocol SavedArticlesRepository {
    func fetchAll() -> [SavedArticleModel]
    func save(_ article: SavedArticleModel)
    func delete(id: String)
    func isSaved(id: String) -> Bool
}
