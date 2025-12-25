//
//  AppConfig.swift
//  NewsApp
//
//  Created by Avinash on 25/12/25.
//

import Foundation

struct AppConfig {

    static let apiKey: String = {
        guard let key = Bundle.main.object(
            forInfoDictionaryKey: "NEWS_API_KEY"
        ) as? String,
        !key.isEmpty else {
            fatalError("❌ NEWS_API_KEY missing in Info.plist")
        }
        return key
    }()

    static let baseURL: String = {
        guard let url = Bundle.main.object(
            forInfoDictionaryKey: "BASE_URL"
        ) as? String,
        !url.isEmpty else {
            fatalError("❌ BASE_URL missing in Info.plist")
        }
        return url
    }()
}

