//
//  DashboardPage.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 16/12/24.
//

import SwiftUI

struct DashboardPage: View {
    
    @State private var isNavigate = false
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
                HomePage(isNavigate: $isNavigate, selectedTask: $selectedTask).tag(0)
                CalendarPage().tag(1)
                EmptyView().tag(2)
            }
            
            CustomTabBar(currentIndex: selectedTab, items: tabItems) { index in
                if index == 2 {
                    isNavigate = true
                } else {
                    selectedTab = index
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .safeAreaPadding()
        .onAppear {
            selectedTask = nil
        }
        
        NavigationLink(value: isNavigate) {
            EmptyView()
        }.navigationDestination(isPresented: $isNavigate) {
            if selectedTask != nil {
                EditTaskPage(entity: selectedTask!, isNavigate: $isNavigate)
            } else {
                AddTaskPage(isNavigate: $isNavigate)
            }
        }
    }
    
}

#Preview {
    DashboardPage()
}
