//
//  GetCalendarVM.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 25/12/24.
//

import Foundation
import SwiftUI
import SwiftUICore
import CoreData

class GetCalendarVM: ObservableObject {
        
    @Published var selectedDate: Date = Date()
    @Published var weeklyDates: [Date] = []
    @Published var tasks: [TaskEntity] = []
    
    init() {
        weeklyDates = selectedDate.getWeeklyDates()
    }
        
    private var viewContext: NSManagedObjectContext {
        return PersistenceController.shared.context
    }
    
    
    func nextWeek() {
        selectedDate = selectedDate.addingTimeInterval(TimeInterval(+7 * 24 * 60 * 60))
        weeklyDates = selectedDate.getWeeklyDates()
        getTasks()
    }
    
    func previousWeek() {
        selectedDate = selectedDate.addingTimeInterval(TimeInterval(-7 * 24 * 60 * 60))
        weeklyDates = selectedDate.getWeeklyDates()
        getTasks()
    }
    
    func getTasks() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskEntity")
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: weeklyDates.first!)
        let endOfDay = calendar.date(byAdding: .day, value: 7, to: startOfDay)!
        fetchRequest.predicate = NSPredicate(
            format: "dueAt >= %@ AND dueAt < %@",
            startOfDay as NSDate,
            endOfDay as NSDate
        )
        do {
            self.tasks = try viewContext.fetch(fetchRequest) as? [TaskEntity] ?? []
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func filterTasks(_ date: Date) -> [TaskEntity] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
                
        return self.tasks.filter { entity in
            if let dueAt = entity.dueAt {
                return dueAt >= startOfDay && dueAt < endOfDay
            }
            return false
        }
        
    }
}

