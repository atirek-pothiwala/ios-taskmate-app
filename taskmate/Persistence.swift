//
//  Persistence.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 15/12/24.
//

import CoreData
import UIKit

struct PersistenceController {
    static let shared = PersistenceController()

    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    func sampleEntity() -> TaskEntity {
        let newItem = TaskEntity(context: context)
        newItem.id = UUID()
        newItem.title = "Watch Anime"
        newItem.details = "I want to watch an anime called 'One Piece' with friends."
        newItem.dueAt = Date()
        newItem.duration = Int32(2)
        newItem.createdAt = Date()
        newItem.priority = Int32(TaskPriority.normal.rawValue)
        newItem.status = 0

        return newItem
    }
    
    @MainActor
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        
        let viewContext = result.container.viewContext
        for i in 0..<10 {
            let newItem = TaskEntity(context: viewContext)
            newItem.title = "Title \(i)"
            newItem.details = "Details \(i)"
            newItem.dueAt = Date()
            newItem.duration = 1
            newItem.createdAt = Date()
            newItem.priority = 0
            newItem.status = 0
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "taskmate")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
