//
//  SavedArticlesRepositoryImpl.swift
//  NewsApp
//
//  Created by Avinash on 26/12/25.
//

import Foundation
import CoreData

final class SavedArticlesRepositoryImpl: SavedArticlesRepository {

    private let context: NSManagedObjectContext

    init(persistence: PersistenceController) {
        self.context = persistence.context
    }

    // MARK: - Fetch
    func fetchAll() -> [SavedArticleModel] {

        let request: NSFetchRequest<SavedNews> = SavedNews.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "savedAt", ascending: false)
        ]

        let items = (try? context.fetch(request)) ?? []

        return items.map {
            SavedArticleModel(
                id: $0.id ?? "",
                title: $0.title ?? "",
                desc: $0.desc ?? "",
                url: $0.url ?? "",
                imageData: $0.imageData,
                savedAt: $0.savedAt ?? Date()
            )
        }
    }

    // MARK: - Save
    func save(_ article: SavedArticleModel) {
        context.perform {

            if self.isSaved(id: article.id) {
                return
            }

            let entity = SavedNews(context: self.context)
            entity.id = article.id
            entity.title = article.title
            entity.desc = article.desc
            entity.url = article.url
            entity.imageData = article.imageData
            entity.savedAt = article.savedAt

            do {
                try self.context.save()
            } catch {
                print("❌ Core Data save error:", error)
            }
        }
    }

    // MARK: - Delete
    func delete(id: String) {
        context.perform {
            let request: NSFetchRequest<SavedNews> = SavedNews.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", id)

            do {
                let items = try self.context.fetch(request)
                items.forEach { self.context.delete($0) }
                try self.context.save()
            } catch {
                print("❌ Core Data delete error:", error)
            }
        }
    }

    // MARK: - Exists
    func isSaved(id: String) -> Bool {
        let request: NSFetchRequest<SavedNews> = SavedNews.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        request.fetchLimit = 1

        let count = (try? context.count(for: request)) ?? 0
        return count > 0
    }
}
