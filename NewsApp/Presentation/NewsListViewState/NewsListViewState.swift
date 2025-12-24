//
//  NewsListViewState.swift
//  NewsApp
//
//  Created by Avinash on 24/12/25.
//

import Foundation

enum NewsListViewState {
    case loading
    case loaded
    case empty
    case error(String)
}

