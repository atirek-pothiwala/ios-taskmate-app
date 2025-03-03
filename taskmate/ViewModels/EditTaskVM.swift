//
//  EditTaskVM.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 31/01/25.
//

import Foundation
import SwiftUICore
import CoreData

class EditTaskVM: ObservableObject {
    
    
    init(entity: TaskEntity) {
        self.taskId = entity.objectID
        self.taskPriority = TaskPriority(rawValue: Int(entity.priority))!
        self.taskName = entity.title!
        self.taskDescription = entity.details!
        self.taskDateTime = entity.dueAt!
        self.taskHours = Int(entity.duration)
    }

    let taskId: NSManagedObjectID
    @Published var isTaskSaved: Bool = false
    @Published var taskPriority: TaskPriority = .high
    @Published var taskName: String = ""
    @Published var taskDescription: String = ""
    @Published var taskDateTime: Date = Date()
    @Published var taskHours: Int = 1
    
    var viewContext: NSManagedObjectContext {
        return PersistenceController.shared.context
    }
    
    var taskDateInText: String {
        taskDateTime.formatDate("dd MMM, yy")
    }
    
    var taskTimeInText: String {
        taskDateTime.formatDate("hh:mm a")
    }
    
    var taskHoursInText: String {
        return taskHours > 1 ? "\(taskHours) hours" : "\(taskHours) hour"
    }
    
    func isValid() -> Bool {
        return !taskName.isEmpty && !taskDescription.isEmpty
    }
    
    func updateTask(onSuccess: () -> Void, onFailure: () -> Void) {
        do {
            if let newItem = try viewContext.existingObject(with: taskId) as? TaskEntity {
                newItem.title = taskName
                newItem.details = taskDescription
                newItem.dueAt = taskDateTime
                newItem.duration = Int32(taskHours)
                newItem.priority = Int32(taskPriority.rawValue)
                newItem.status = 0
                
                try viewContext.save()
                onSuccess()
            }
        } catch {
            let nsError = error as NSError
            debugPrint("Unresolved error \(nsError), \(nsError.userInfo)")
            onFailure()
        }
    }
}
