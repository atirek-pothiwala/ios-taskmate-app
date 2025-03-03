//
//  TimelinePickerSheet.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 23/12/24.
//

import SwiftUI

typealias OnSaveTimelineEvent = (Date, Int) -> Void

struct TimelinePickerSheet: View {
    
    @Binding private var isPresent: Bool
    @FocusState private var isFocused: Bool
    
    private let title: String
    @State private var date: Date = Date.now
    @State private var hours: Int = 1
    @State private var sheetHeight: CGFloat = .zero
    private let onSaveEvent: OnSaveTimelineEvent
    
    init(isPresent: Binding<Bool>, title: String, date: Date, hours: Int, onSaveEvent: @escaping OnSaveTimelineEvent) {
        self._isPresent = isPresent
        self.title = title
        self.date = date
        self.hours = hours
        self.onSaveEvent = onSaveEvent
    }
        
    var header: some View {
        HStack(alignment: .center) {
            
            Text(title)
                .foregroundStyle(.black)
                .font(.title2)
                .fontWeight(.semibold)
            
            Spacer()
            
            Button {
                isPresent = false
            } label: {
                Image.init(systemName: "xmark")
                    .foregroundStyle(.black)
                    .font(.title3)
            }
        }
        .padding(.all, 20)
    }
    var textField: some View {
        DatePicker(title, selection: $date)
            .datePickerStyle(.graphical)
            .tint(.black)
            .labelsHidden()
            .frame(maxWidth: .infinity)
    }
    var btnSave: some View {
        Button {
            isPresent = false
            onSaveEvent(date, hours)
        } label: {
            Text("Save")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.vertical, 25)
                .padding(.horizontal, 35)
        }
        .frame(minWidth: 200, maxWidth: .infinity)
        .foregroundColor(.white)
        .background(Color.black)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            header
            
            Rectangle()
                .frame(height: 10)
                .foregroundStyle(.gray.opacity(0.1))
            
            textField
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            
            Rectangle()
                .frame(height: 5)
                .foregroundStyle(.gray.opacity(0.1))
            
            Stepper(value: $hours, in: 1...12) {
                HStack(alignment: .center) {
                    Text("Duration:")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text(hours > 1 ? "\(hours) hours" : "\(hours) hour")
                        .font(.title2)
                        .fontWeight(.regular)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 15)
            .padding(.bottom, 20)

            btnSave
                .ignoresSafeArea()
        }
        .toResizableSheet(height: $sheetHeight)
    }
}

#Preview {
    TimelinePickerSheet(isPresent: Binding.constant(false),
                        title: "Set Timeline",
                        date: Date(),
                        hours: 2) { date, hours in
        debugPrint("Date: \(date.formatDate("dd MMM yyyy - hh:mm a"))")
        debugPrint("Hours: \(hours)")
    }
}
