//
//  CalendarPage.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 16/12/24.
//

import SwiftUI

struct CalendarPage: View, ChangeDateDelegate {
    
    @StateObject private var viewModel = GetCalendarVM()
    
    func onNextWeek() {
        viewModel.nextWeek()
    }
    
    func onPreviousWeek() {
        viewModel.previousWeek()
    }
                    
    var body: some View {
        VStack {
            ChangeDateView(
                selectedDate: $viewModel.selectedDate,
                weeklyDates: $viewModel.weeklyDates,
                delegate: self
            )
            .padding(.bottom, 15)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(viewModel.weeklyDates, id: \.self) { item in
                        CalendarCell(item, viewModel.filterTasks(item))
                    }
                }
                .padding(.bottom, UIScreen.safeAreaMargin)
            }
            .scrollBounceBehavior(.basedOnSize, axes: .vertical)
        }
        .safeAreaPadding(.all, 20)
        .onAppear {
            viewModel.getTasks()
        }
        
    }
}

#Preview {
    CalendarPage()
}
