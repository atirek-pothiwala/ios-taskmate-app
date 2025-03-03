//
//  TaskCell.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 16/12/24.
//

import SwiftUI
import CoreData
import SwiftUICore


protocol OnTaskClick {
    func onTaskTap(_ entity: TaskEntity) -> Void
    func onTaskLongPress(_ entity: TaskEntity) -> Void
}

struct TaskCell: View {
    let entity: TaskEntity
    let onTaskClick: OnTaskClick?
    
    init(entity: TaskEntity, onTaskClick: OnTaskClick?) {
        self.entity = entity
        self.onTaskClick = onTaskClick
    }
    
    var body: some View {
        let taskPriority = TaskPriority(rawValue: Int(entity.priority))!
        let dueAt = entity.dueAt!
        let duration = entity.duration
        
        HStack(alignment: .top, spacing: 15) {
            
            VStack(alignment: .center, spacing: 0) {
                Text(dueAt.formatDate("dd"))
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(taskPriority.color)
                    
                Text(dueAt.formatDate("MMM"))
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(taskPriority.color)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                
                HStack(alignment: .center, spacing: 10) {
                    Text(entity.title!)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                    
                    Spacer()
                    
                    Text(taskPriority.name)
                        .font(.footnote)
                        .fontWeight(.regular)
                        .foregroundStyle(.black)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder()
                                .foregroundStyle(.black)
                                .background(.white)
                                .cornerRadius(10)
                        }
                }
                                    
                HStack(alignment: .center, spacing: 5) {
                    
                    Image(systemName: "clock")
                        .font(.footnote)
                        .fontWeight(.light)
                        .foregroundStyle(.black)
                    
                    Text("\(dueAt.formatDate("hh:mm a")) | \(duration)h")
                        .font(.footnote)
                        .fontWeight(.light)
                        .foregroundStyle(.black)
                }
                
                Text(entity.details!)
                    .font(.callout)
                    .fontWeight(.regular)
                    .foregroundStyle(.black)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.all, 20)
        .background(taskPriority.color.opacity(0.2))
        .cornerRadius(25)
        .onTapGesture {
            self.onTaskClick?.onTaskTap(entity)
        }
        .onLongPressGesture {
            self.onTaskClick?.onTaskLongPress(entity)
        }
    }
}


#Preview {
    TaskCell(
        entity: PersistenceController.shared.sampleEntity(), onTaskClick: nil)
}
