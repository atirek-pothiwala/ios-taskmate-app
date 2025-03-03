//
//  HomePage.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 16/12/24.
//

import SwiftUI

struct HomePage: View, OnTaskClick {
    @StateObject private var viewModel = GetTasksVM()
    
    @Binding private var isNavigate: Bool
    @Binding private var selectedTask: TaskEntity?
    
    init(isNavigate: Binding<Bool>, selectedTask: Binding<TaskEntity?>) {
        _isNavigate = isNavigate
        _selectedTask = selectedTask
    }
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Tasks")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                Spacer()
            }
            
            FilterView(currentIndex: viewModel.status, items: viewModel.filters) { index in
                viewModel.status = index
                viewModel.getTasks()
            }
            
            if viewModel.tasks.isEmpty {
                Text("No tasks found")
                    .font(.callout)
                    .frame(maxHeight: .infinity, alignment: .center)
                    .padding(.bottom, UIScreen.safeAreaMargin)
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 15) {
                        ForEach(viewModel.tasks, id: \.self) { item in
                            TaskCell(entity: item, onTaskClick: self)
                        }
                    }
                    .padding(.bottom, UIScreen.safeAreaMargin)
                }
                .scrollBounceBehavior(.basedOnSize, axes: .vertical)

            }
            
        }
        .safeAreaPadding(.all, 20)
        .onAppear {
            viewModel.getTasks()
        }
    }
    
    func onTaskTap(_ entity: TaskEntity) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        self.selectedTask = entity
        self.isNavigate = true
    }
    
    func onTaskLongPress(_ entity: TaskEntity) {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
}
