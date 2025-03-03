//
//  Date+Extension.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 19/12/24.
//

import Foundation

extension Date {
    
    func getWeeklyDates() -> [Date] {
        let calendar: Calendar = .current
        // Get the current week's range (e.g., Sunday to Saturday)
        guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: self) else {
            return []
        }

        // Generate the list of weekly dates
        let weekStartDate = weekInterval.start
        var weeklyDates: [Date] = []
        for i in 0..<7 {
            if let nextDate = calendar.date(byAdding: .day, value: i, to: weekStartDate) {
                weeklyDates.append(nextDate)
            }
        }

        return weeklyDates
    }
    
    static private var dateFormatter: DateFormatter?
    
    func formatDate(_ format: String) -> String {
        if Date.dateFormatter == nil {
            Date.dateFormatter = DateFormatter()
        }
        Date.dateFormatter!.dateFormat = format
        return Date.dateFormatter!.string(from: self)
    }
}
