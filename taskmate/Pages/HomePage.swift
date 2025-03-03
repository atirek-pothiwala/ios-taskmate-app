//
//  HomeView.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 16/12/24.
//

import SwiftUI

struct HomePage: View {

    @State var filterIndex: Int = 0
    
    var tasks: [TaskModel] {
        return Constants.allTasks.filter { model in
            return model.status == filterIndex
        }
    }
    
    var body: some View {
        NavigationStack {
            
            VStack(spacing: 20) {
                HStack {
                    Text("Tasks")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                }
                
                FilterView(currentIndex: filterIndex, items: [
                    "To Do", "In Progress", "Done"
                ]) { index in
                    filterIndex = index
                }
             
                ScrollView(.vertical) {
                    VStack(spacing: 15) {
                        ForEach(Array(tasks.enumerated()), id: \.offset) { index, item in
                         
                            TaskCell(model: item) {
                                debugPrint("Click on Task: \(item.title)")
                            }
                        }
                    }
                    .padding(.bottom, Constants.safeAreaBottom + Constants.deviceHeight * 0.2)
                    
                }
                .scrollBounceBehavior(.basedOnSize, axes: .vertical)
                .scrollIndicators(.never)
            }.safeAreaPadding(.all, 20)
        }
    }
}

#Preview {
    HomePage()
}
