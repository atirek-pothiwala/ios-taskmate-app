//
//  ChangeDateView.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 19/12/24.
//

import SwiftUI

protocol ChangeDateDelegate {
    func onPreviousWeek()
    func onNextWeek()
}

struct ChangeDateView: View {
    
    @Binding var selectedDate: Date
    @Binding var weeklyDates: [Date]
    let delegate: ChangeDateDelegate?
    
    init(selectedDate: Binding<Date>,
         weeklyDates: Binding<[Date]>,
         delegate: ChangeDateDelegate?) {
        _selectedDate = selectedDate
        _weeklyDates = weeklyDates
        self.delegate = delegate
    }
    
    private var dtStart: String {
        return weeklyDates.first!.formatDate("dd MMM, yy")
    }
    
    private var dtEnd: String {
        return weeklyDates.last!.formatDate("dd MMM, yy")
    }
    
    var body: some View {
        HStack {
            btnPreviousWeek()
            
            Spacer()
                        
            Text("\(dtStart) - \(dtEnd)")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
            
            Spacer()

            btnNextWeek()
        }
        .padding(.all, 15)
        .background {
            RoundedRectangle(cornerRadius: 25)
                .strokeBorder()
                .foregroundStyle(.black)
        }
    }
    
    func btnPreviousWeek() -> some View {
        Button {
            delegate?.onPreviousWeek()
        } label: {
            Image(systemName: "arrow.left.circle.dotted")
                .font(.largeTitle)
                .fontWeight(.regular)
                .foregroundStyle(.black)
        }
    }
    
    func btnNextWeek() -> some View {
        Button {
            delegate?.onNextWeek()
        } label: {
            Image(systemName: "arrow.right.circle.dotted")
                .font(.largeTitle)
                .fontWeight(.regular)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    ChangeDateView(selectedDate: Binding<Date>.constant(Date()),
                   weeklyDates: Binding<[Date]>.constant([]),
                   delegate: nil)
}
