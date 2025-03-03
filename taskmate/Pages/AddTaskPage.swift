//
//  AddTaskPage.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 16/12/24.
//

import SwiftUI

struct AddTaskPage: View {
    
    @Binding var isNavigate: Bool
    @State private var isPresentDescription: Bool = false
    @State private var isPresentDate: Bool = false
    
    @FocusState private var isFocused: Bool
    @StateObject private var viewModel = AddTaskVM()
            
    var header: some View {
        VStack(alignment: .leading, spacing: 20) {
            BackButtonView(title: "Add new task") {
                isNavigate = false
            }
            HStack {
                Text("Set Priority")
                    .font(.largeTitle)
                    .fontWeight(.black)
                Spacer()
                btnChangePriority
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
    }
    
    var btnChangePriority: some View {
        Menu {
            Button(TaskPriority.high.name) {
                viewModel.taskPriority = .high
            }
            Button(TaskPriority.normal.name) {
                viewModel.taskPriority = .normal
            }
            Button(TaskPriority.low.name) {
                viewModel.taskPriority = .low
            }
        } label: {
            HStack(alignment: .center, spacing: 10) {
                Text(viewModel.taskPriority.name)
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundStyle(viewModel.taskPriority.color)
                Image(systemName: "chevron.down")
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundStyle(viewModel.taskPriority.color)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
        }
        .background {
            RoundedRectangle(cornerRadius: 15)
                .strokeBorder(lineWidth: 1)
                .foregroundStyle(viewModel.taskPriority.color)
        }
    }
        
    var tfTaskName: some View {
        VStack(alignment: .leading, spacing: 5) {
            TextField(text: $viewModel.taskName) {
                Text("Task name").foregroundStyle(.gray)
            }
            .textContentType(.name)
            .font(.headline)
            .textInputAutocapitalization(.words)
            .textFieldStyle(.plain)
            .foregroundStyle(.black)
            .tint(.black)
            .focused($isFocused)
            .onSubmit {
                UIScreen.dismissKeyboard()
            }
            .padding(.bottom, 5)

            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.gray)
        }
        .padding(.horizontal, 25)
    }
    
    var timeline: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Timeline")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundStyle(.black)
                
                Spacer()
                
                btnEditTimeline
            }
            .padding(.horizontal, 25)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 10) {
                    scheduleDate
                    scheduleTime
                    scheduleHours
                }
            }
            .contentMargins(.horizontal, 25)

        }
    }
    
    var scheduleDate: some View {
        HStack(alignment: .center, spacing: 5) {
            Text(viewModel.taskDateInText)
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundStyle(.black)
            Image(systemName: "calendar")
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundStyle(.black)
        }
        .padding(.all, 10)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.red.opacity(0.2))
        }
    }
    
    var scheduleTime: some View {
        HStack(alignment: .center, spacing: 5) {
            Text(viewModel.taskTimeInText)
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundStyle(.black)
            Image(systemName: "clock")
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundStyle(.black)
        }
        .padding(.all, 10)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.green.opacity(0.2))
        }
    }
    
    var scheduleHours: some View {
        HStack(alignment: .center, spacing: 5) {
            Text(viewModel.taskHoursInText)
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundStyle(.black)
            Image(systemName: "alarm")
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundStyle(.black)
        }
        .padding(.all, 10)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.blue.opacity(0.2))
        }
    }
    
    var btnEditTimeline: some View {
        Button("Edit") {
            isPresentDate = true
        }
        .font(.subheadline)
        .fontWeight(.medium)
        .foregroundStyle(.white)
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.black)
        }
        .sheet(isPresented: $isPresentDate) {
            isPresentDate = false
        } content: {
            TimelinePickerSheet(isPresent: $isPresentDate, title: "Set Timeline", date: viewModel.taskDateTime, hours: viewModel.taskHours) { date, hours in
                viewModel.taskDateTime = date
                viewModel.taskHours = hours
            }
        }
    }
    
    var tfDescription: some View {
        
        VStack(alignment: .leading, spacing: 15) {
            
            Text("Description")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(.black)
            
            TextField(text: $viewModel.taskDescription, axis: .vertical) {
                Text("Enter your description here...")
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
        .padding(.horizontal, 25)
    }
    
    var btnAddTask: some View {
        Button {
            viewModel.addTask {
                isNavigate = false
            } onFailure: {
                
            }

        } label: {
            HStack {
                Text("Add Task")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Image(systemName: "plus.app")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .padding(.vertical, 25)
            .padding(.horizontal, 35)
        }
        .frame(minWidth: 200, maxWidth: .infinity)
        .foregroundColor(.white)
        .disabled(!viewModel.isValid())
        .background(!viewModel.isValid() ? Color .gray.opacity(0.5) : Color.black)
        .ignoresSafeArea()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            header
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 25) {
                    tfTaskName
                    timeline
                    tfDescription
                }
                .padding(.vertical, 15)
            }
            
            btnAddTask
        }
        .onTapGesture {
            isFocused = false
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    AddTaskPage(isNavigate: Binding.constant(false))
}
