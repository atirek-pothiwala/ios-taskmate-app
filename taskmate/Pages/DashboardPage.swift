//
//  DashboardView.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 16/12/24.
//

import SwiftUI

struct DashboardPage: View {
    
    @State private var isNavigate = false
    
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
                HomeView().tag(0)
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
                
        NavigationLink(value: isNavigate) {
            EmptyView()
        }.navigationDestination(isPresented: $isNavigate) {
            AddTaskPage(isNavigate: $isNavigate)
        }
    }
}

#Preview {
    DashboardPage()
}
