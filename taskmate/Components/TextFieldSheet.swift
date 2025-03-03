//
//  TextFieldSheet.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 22/12/24.
//

import SwiftUI

typealias OnSaveTextEvent = (String) -> Void

struct TextFieldSheet: View {
    
    @Binding private var isPresent: Bool
    @FocusState private var isFocused: Bool
    
    private let title: String
    @State private var input: String = ""
    private let onSaveTextEvent: OnSaveTextEvent
    
    init(isPresent: Binding<Bool>, title: String, input: String, onSaveTaskEvent: @escaping OnSaveTextEvent) {
        self._isPresent = isPresent
        self.title = title
        self.input = input
        self.onSaveTextEvent = onSaveTaskEvent
    }
    
    @State private var sheetHeight: CGFloat = .zero
    
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
        TextField(text: $input, axis: .vertical) {
            Text("Type here...")
                .foregroundStyle(.gray)
        }
        .textContentType(.name)
        .font(.headline)
        .textInputAutocapitalization(.sentences)
        .textFieldStyle(.plain)
        .foregroundStyle(.black)
        .multilineTextAlignment(.leading)
        .lineLimit(5, reservesSpace: true)
        .tint(.black)
        .focused($isFocused)
        .onSubmit {
            UIScreen.dismissKeyboard()
        }
        .padding(.all, 20)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.gray.opacity(0.1))
        }
    }
    var btnSave: some View {
        Button {
            isPresent = false
            onSaveTextEvent(input)
        } label: {
            Text("Save")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.vertical, 25)
                .padding(.horizontal, 35)
        }
        .frame(minWidth: 200, maxWidth: .infinity)
        .foregroundColor(.white)
        .disabled(input.isEmpty)
        .background(input.isEmpty ? Color .gray.opacity(0.5) : Color.black)
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
    TextFieldSheet(isPresent: Binding.constant(false), title: "Task Description", input: "") { input in
        debugPrint("Input: \(input)")
    }
}
