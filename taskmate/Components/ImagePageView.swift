//
//  ImagePageView.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 16/12/24.
//

import SwiftUI

struct ImagePageView: View {
    let images: [String]
    
    init(images: [String], indicatorColor: Color = .black) {
        self.images = images
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(indicatorColor)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(indicatorColor.opacity(0.15))
    }
    
    @State private var currentPage = 0

    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(0..<images.count, id: \.self) {
                index in
                
                LevitatingImageView(images[index])
                    .padding(.horizontal, 25)
                
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .onAppear(perform: onAutoScroll)
    }
    
    func onAutoScroll() {
        Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) {
            timer in
            
            DispatchQueue.main.async {
                withAnimation {
                    currentPage = currentPage + 1
                    if currentPage >= images.count {
                        currentPage = 0
                    }
                }
            }
        }
    }
}

#Preview {
    ImagePageView(images: [
        "icDailyTasks",
        "icPlan",
        "icScheduleTasks"
    ])
}
