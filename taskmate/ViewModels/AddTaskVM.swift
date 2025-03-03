//
//  AddTaskVM.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 22/12/24.
//

import Foundation
import SwiftUICore
import CoreData

enum TaskPriority: Int {
    case low = 0, normal = 1, high = 2
}

extension TaskPriority {
    
    var name: String {
        switch self {
        case .high:
            return "High"
        case .normal:
            return "Normal"
        case .low:
            return "Low"
        }
    }
    
    var color: Color {
        switch self {
        case .high:
            return Color.red
        case .normal:
            return Color.blue
        case .low:
            return Color.green
        }
    }
}

class AddTaskVM: ObservableObject {
    
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
    
    func addTask(onSuccess: () -> Void, onFailure: () -> Void) {
        let newItem = TaskEntity(context: viewContext)
        newItem.id = UUID()
        newItem.title = taskName
        newItem.details = taskDescription
        newItem.dueAt = taskDateTime
        newItem.duration = Int32(taskHours)
        newItem.createdAt = Date()
        newItem.priority = Int32(taskPriority.rawValue)
        newItem.status = 0

        do {
            try viewContext.save()
            onSuccess()
        } catch {
            let nsError = error as NSError
            debugPrint("Unresolved error \(nsError), \(nsError.userInfo)")
            onFailure()
        }
    }
}
