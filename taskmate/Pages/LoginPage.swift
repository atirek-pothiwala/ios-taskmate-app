//
//  LoginPage.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 15/12/24.
//

import SwiftUI

struct LoginPage: View {
    
    @State private var isNavigate = false
    
    var body: some View {
        NavigationStack {
            
            VStack(alignment: .center, spacing: 30) {
                
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 50)
                        .foregroundStyle(
                            Color.gradient(colors: [
                                Color.purpleDark,
                                Color.purpleMedium,
                                Color.purpleLight1,
                                Color.purpleLight2,
                            ])
                        )
                    
                    ImagePageView(images: [
                        "icDailyTasks",
                        "icPlan",
                        "icScheduleTasks"
                    ])
                }
                .frame(maxHeight: .infinity)
                
                Text("Plan, manage and track tasks")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.black)
                
                CustomButton(title: "Continue", imageName: "chevron.up.right.dotted.2") {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    isNavigate = true
                }
            }
            .safeAreaPadding(.all, 30)
            
            NavigationLink(value: isNavigate) {
                EmptyView()
            }.navigationDestination(isPresented: $isNavigate) {
                DashboardPage()
            }
        }
    }
}

#Preview {
    LoginPage()
}
