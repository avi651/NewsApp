//
//  ImageDownloader.swift
//  NewsApp
//
//  Created by Avinash on 26/12/25.
//

import Foundation

final class ImageDownloader {

    static let shared = ImageDownloader()

    private let cache = NSCache<NSString, NSData>()

    private init() {}

    /// Downloads image and returns Data (with in-memory cache)
    func download(
        from urlString: String,
        completion: @escaping (Data?) -> Void
    ) {
        // Validate URL
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        // Check cache
        if let cached = cache.object(forKey: urlString as NSString) {
            completion(cached as Data)
            return
        }

        // Network call
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self,
                  let data,
                  error == nil else {
                completion(nil)
                return
            }

            // Cache image
            self.cache.setObject(data as NSData, forKey: urlString as NSString)

            completion(data)
        }.resume()
    }
}
