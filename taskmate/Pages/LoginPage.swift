//
//  LoginPage.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 15/12/24.
//

import SwiftUI

struct LoginPage: View {
    
    @State private var navigateToDashboard = false
    
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
                .frame(minHeight: 200, maxHeight: .infinity)
                
                Text("Plan, manage and track tasks")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                CustomButton(title: "Continue", imageName: "chevron.up.right.dotted.2") {
                    navigateToDashboard = true
                }
            }
            .safeAreaPadding(.all, 30)
            
            NavigationLink(value: navigateToDashboard) {
                EmptyView()
            }.navigationDestination(isPresented: $navigateToDashboard) {
                DashboardPage()
            }
        }
    }
}

#Preview {
    LoginPage()
}
