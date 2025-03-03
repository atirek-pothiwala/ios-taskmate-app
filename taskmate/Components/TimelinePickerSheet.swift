//
//  TimelinePickerSheet.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 23/12/24.
//

import SwiftUI

typealias OnSaveDateEvent = (Date) -> Void

struct TimelinePickerSheet: View {
    
    @Binding private var isPresent: Bool
    @FocusState private var isFocused: Bool
    
    private let title: String
    @State private var input = Date.now
    @State private var sheetHeight: CGFloat = .zero
    private let onSaveDateEvent: OnSaveDateEvent
    
    init(isPresent: Binding<Bool>, title: String, input: Date, onSaveDateEvent: @escaping OnSaveDateEvent) {
        self._isPresent = isPresent
        self.title = title
        self.input = input
        self.onSaveDateEvent = onSaveDateEvent
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
        DatePicker(title, selection: $input)
            .datePickerStyle(.graphical)
            .tint(.black)
            .labelsHidden()
            .frame(maxWidth: .infinity)
    }
    var btnSave: some View {
        Button {
            isPresent = false
            onSaveDateEvent(input)
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
            textField
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            btnSave
                .ignoresSafeArea()
        }
        .toResizableSheet(height: $sheetHeight)
    }
}

#Preview {
    TimelinePickerSheet(isPresent: Binding.constant(false), title: "Set Date", input: Date()) { input in
        debugPrint(input.formatDate("dd MMM, yy"))
    }
}
