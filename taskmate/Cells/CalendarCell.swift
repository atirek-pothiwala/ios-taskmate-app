//
//  CalendarCell.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 19/12/24.
//

import SwiftUI
import SwiftUICore
import CoreData

struct CalendarCell: View {
    
    private let date: Date
    private let tasks: [TaskEntity]
    
    init(_ date: Date, _ tasks: [TaskEntity]) {
        self.date = date
        self.tasks = tasks
    }
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        let isCurrentDate = date.formatDate("dd-MM-yy") == Date().formatDate("dd-MM-yy")
        let weekDate = date.formatDate("dd")
        let weekDay = date.formatDate("EEE")
        
        HStack(alignment: .top) {
            VStack(alignment: .center) {
                Text(weekDay)
                    .font(.title3)
                    .fontWeight(.semibold)
                Text(weekDate)
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding(.vertical, 8)
            .padding(.trailing, 8)
            .foregroundStyle(isCurrentDate ? .blue : .black)
            
            if !self.tasks.isEmpty {
                LazyVGrid(columns: self.columns, spacing: 8) {
                    ForEach(self.tasks, id: \.self) { entity in
                        StickyTaskCell(entity)
                    }
                }
                .frame(maxWidth: .infinity)
            } else {
                Text("No tasks")
                    .foregroundStyle(.gray)
                    .fontWeight(.light)
                    .frame(maxWidth: .infinity, minHeight: 100)
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(.gray.opacity(0.05))
                    }
                    .padding(.trailing, 15)
            }
        }
    }
}

#Preview {
    CalendarCell(Date(), [])
}
