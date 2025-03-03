//
//  TextFieldSheet.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 22/12/24.
//

import SwiftUI

struct TextFieldSheet: View {
    
    @Binding private var isPresent: Bool
    @FocusState private var isFocused: Bool
    
    private let title: String
    @Binding private var message: String
    
    init(isPresent: Binding<Bool>, title: String, message: Binding<String>) {
        self._isPresent = isPresent
        self.title = title
        self._message = message
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
                isPresent.toggle()
            } label: {
                Image.init(systemName: "xmark")
                    .foregroundStyle(.black)
                    .font(.title3)
            }
        }
        .padding(.all, 20)
    }
    var textField: some View {
        TextField(text: $message, axis: .vertical) {
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

        } label: {
            Text("Save")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.vertical, 25)
                .padding(.horizontal, 35)
        }
        .frame(minWidth: 200, maxWidth: .infinity)
        .foregroundColor(.white)
        .disabled(message.isEmpty)
        .background(message.isEmpty ? Color .gray.opacity(0.5) : Color.black)
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
        .overlay {
            GeometryReader { geometry in
                Color.clear.preference(key: InnerHeightPreferenceKey.self, value: geometry.size.height)
            }
        }
        .onPreferenceChange(InnerHeightPreferenceKey.self) { newHeight in
            self.sheetHeight = newHeight
        }
        .presentationDetents([.height(sheetHeight)])
    }
}

fileprivate struct InnerHeightPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    TextFieldSheet(isPresent: Binding.constant(false), title: "Task Description", message: Binding.constant(""))
}
