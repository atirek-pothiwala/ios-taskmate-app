//
//  AddTaskView.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 16/12/24.
//

import SwiftUI

struct AddTaskView: View {
    
    @Binding var isNavigate: Bool

    @State var taskName: String = ""
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                HStack(alignment: .center) {
                    
                    Button {
                        isNavigate.toggle()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .font(.title3)
                            .fontWeight(.regular)
                        
                        Text("Add new task")
                            .font(.title3)
                            .fontWeight(.regular)
                    }.foregroundStyle(.black)

                    Spacer()
                }
                HStack {
                    Text("Set Priority")
                        .font(.largeTitle)
                        .fontWeight(.black)
                    
                    Spacer()
                }
            }
            .padding(.horizontal, 25)
            .padding(.top, 15)
            .padding(.bottom, 25)
            .background {
                UnevenRoundedRectangle(
                    cornerRadii: .init(
                        topLeading: 0,
                        bottomLeading: 30,
                        bottomTrailing: 30,
                        topTrailing: 0
                    )
                )
                .foregroundStyle(Color.gray.opacity(0.1))
                .ignoresSafeArea()
            }
            
            TextField(text: $taskName) {
                Text("Task Name").foregroundStyle(.gray)
            }
            .textContentType(.name)
            .textInputAutocapitalization(.words)
            .textFieldStyle(.plain)
            .foregroundStyle(.black)
            .padding(.horizontal, 25)
            .padding(.vertical, 15)

            
            Spacer()
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    AddTaskView(isNavigate: Binding<Bool>.constant(false))
}
