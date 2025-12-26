//
//  BookmarkRowView.swift
//  NewsApp
//
//  Created by Avinash on 26/12/25.
//

import SwiftUI
import Kingfisher

struct BookmarkRowView: View {

    let article: SavedArticleModel

    var body: some View {
        HStack(spacing: 12) {

            if let data = article.imageData,
               let uiImage = UIImage(data: data) {

                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 90, height: 70)
                    .clipped()
                    .cornerRadius(8)

            } else {
                Color.gray.opacity(0.3)
                    .frame(width: 90, height: 70)
                    .cornerRadius(8)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(article.title)
                    .font(.headline)
                    .lineLimit(2)

                Text(article.desc)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 6)
    }
}

