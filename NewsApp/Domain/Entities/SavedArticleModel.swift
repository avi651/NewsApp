//
//  SavedArticleModel.swift
//  NewsApp
//
//  Created by Avinash on 26/12/25.
//

import Foundation

struct SavedArticleModel: Identifiable {
    let id: String
    let title: String
    let desc: String
    let url: String
    let imageData: Data?
    let savedAt: Date
}
