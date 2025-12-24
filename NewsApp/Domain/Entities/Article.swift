//
//  Article.swift
//  NewsApp
//
//  Created by Avinash on 23/12/25.
//

import Foundation

struct Article: Identifiable {
    let id = UUID()
    let title: String
    let description: String
}

