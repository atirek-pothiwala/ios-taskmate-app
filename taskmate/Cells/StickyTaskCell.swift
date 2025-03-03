//
//  StickyTaskCell.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 08/01/25.
//

import SwiftUI

struct StickyTaskCell: View {
    let entity: TaskEntity
    
    init(_ entity: TaskEntity) {
        self.entity = entity
    }
    
    var title: String {
        return entity.title ?? ""
    }
    var details: String {
        return entity.details ?? ""
    }
    var dueAt: String {
        return entity.dueAt?.formatDate("hh:mm a") ?? ""
    }
    var taskPriority: TaskPriority {
        let priority = Int(entity.priority)
        return TaskPriority(rawValue: priority)!
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline, spacing: 2.5) {
                Image.init(systemName: "note")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                Text(title)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
            }
            .padding(.bottom, 2.5)
            
            Text(details)
                .font(.caption2)
                .fontWeight(.regular)
                .italic()
                .multilineTextAlignment(.leading)
                .foregroundStyle(.black)
            
            Spacer()
            
            HStack(alignment: .center, spacing: 2.5) {
                Spacer()
                Image(systemName: "clock")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.gray)
                Text("\(dueAt) | \(entity.duration)h")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.gray)
            }
        }
        .padding(.all, 12)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .aspectRatio(1.2, contentMode: .fit)
        .background(taskPriority.color.opacity(0.2))
        .cornerRadius(15)
    }
}

#Preview {
    //StickyTaskCell(nil)
}
