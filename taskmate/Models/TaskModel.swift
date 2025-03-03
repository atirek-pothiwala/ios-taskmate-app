//
//  TaskModel.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 16/12/24.
//

import Foundation
import SwiftUICore

struct TaskModel {
    let id: String
    let title: String
    let hashTag: String
    let color: Color
    let priority: String
    let scheduleDate: String
    let status: Int
    
    init(id: String,
         title: String,
         description: String,
         color: Color,
         priority: String,
         scheduleDate: String,
         status: Int) {
        self.id = id
        self.title = title
        self.hashTag = description
        self.color = color
        self.priority = priority
        self.scheduleDate = scheduleDate
        self.status = status
    }
}
