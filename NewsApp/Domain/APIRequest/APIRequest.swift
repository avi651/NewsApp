//
//  APIRequest.swift
//  NewsApp
//
//  Created by Avinash on 24/12/25.
//

import Foundation

struct APIRequest {
    let url: String
    let method: HTTPMethod
    let headers: [String: String]?
    let body: Data?
}

