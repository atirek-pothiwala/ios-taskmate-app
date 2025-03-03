//
//  GetTasksVM.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 24/12/24.
//

import Foundation
import SwiftUI
import SwiftUICore
import CoreData

class GetTasksVM: ObservableObject {
    
    @Published var filters = [
        "To Do", "In Progress", "Done"
    ]
    @Published var status: Int = 0
    @Published var tasks: [TaskEntity] = []
        
    var viewContext: NSManagedObjectContext {
        return PersistenceController.shared.context
    }
    
    func getTasks() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskEntity")
        fetchRequest.predicate = NSPredicate(format: "status == \(status)")
        do {
            self.tasks = try viewContext.fetch(fetchRequest) as? [TaskEntity] ?? []
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
}

