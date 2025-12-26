//
//  NewsRowView.swift
//  NewsApp
//
//  Created by Avinash on 26/12/25.
//

import SwiftUI
import Kingfisher

struct NewsRowView: View {

    let article: Article
    let isBookmarked: Bool
    let onBookmarkTap: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 12) {

            // 🖼 Image using Kingfisher (cached & fast)
            KFImage(URL(string: article.imageUrl ?? ""))
                .placeholder {
                    Color.gray.opacity(0.3)
                }
                .resizable()
                .cancelOnDisappear(true)
                .scaledToFill()
                .frame(width: 90, height: 70)
                .clipped()
                .cornerRadius(8)

            VStack(alignment: .leading, spacing: 6) {

                Text(article.title)
                    .font(.headline)
                    .lineLimit(2)

                Text(article.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }

            Spacer()

            // 🔖 Bookmark button
            Button(action: onBookmarkTap) {
                Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                    .foregroundColor(.blue)
            }
        }
        .padding(.vertical, 6)
    }
}
