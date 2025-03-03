//
//  DashboardPage.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 16/12/24.
//

import SwiftUI

struct DashboardPage: View {
    
    @State private var isAddTask = false
    @State private var isEditTask = false
    @State private var selectedTask: TaskEntity?
    
    private let tabItems = [
        CustomTabItem(title: "Home", icon: "house"),
        CustomTabItem(title: "Calendar", icon: "calendar"),
        CustomTabItem(title: "Add Task", icon: "plus")
    ]

    @State private var selectedTab: Int = 0
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $selectedTab) {
                HomePage(isNavigate: $isEditTask, selectedTask: $selectedTask).tag(0)
                CalendarPage().tag(1)
                EmptyView().tag(2)
            }
            
            CustomTabBar(currentIndex: selectedTab, items: tabItems) { index in
                if index == 2 {
                    isEditTask = true
                } else {
                    selectedTab = index
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .safeAreaPadding()
        
        editTaskView
        addTaskView
    }
    
    
    var editTaskView: some View {
        NavigationLink(value: isEditTask) {
            EmptyView()
        }.navigationDestination(isPresented: $isEditTask) {
            if selectedTask != nil {
                EditTaskPage(entity: selectedTask!, isNavigate: $isEditTask)
            }
        }
    }
    
    var addTaskView: some View {
        NavigationLink(value: isAddTask) {
            EmptyView()
        }.navigationDestination(isPresented: $isAddTask) {
            AddTaskPage(isNavigate: $isAddTask)
        }
    }
}

#Preview {
    DashboardPage()
}
