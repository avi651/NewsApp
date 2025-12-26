//
//  PersistanceController.swift
//  NewsApp
//
//  Created by Avinash on 26/12/25.
//

import Foundation
import CoreData

final class PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "NewsAppModel")
        if inMemory {
            container.persistentStoreDescriptions.first?.url =
            URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("❌ Core Data load failed: \(error)")
            }
        }
        
        container.viewContext.mergePolicy =
                    NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
}
