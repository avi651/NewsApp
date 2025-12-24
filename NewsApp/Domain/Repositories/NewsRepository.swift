//
//  NewsRepository.swift
//  NewsApp
//
//  Created by Avinash on 23/12/25.
//

import Foundation

protocol NewsRepository {
    func fetchTopHeadlines(page: Int,completion: @escaping ([Article]) -> Void)
    func search(query: String, page: Int, completion: @escaping ([Article]) -> Void)
}
