//
//  PageView.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 16/12/24.
//

import SwiftUI

struct ImagePageView: View {
    let images: [String]
    
    init(images: [String]) {
        self.images = images
    }
    
    @State private var currentPage = 0

    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(0..<images.count, id: \.self) {
                index in
                
                Image(images[index])
                    .resizable()
                    .scaledToFit()
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

#Preview {
    ImagePageView(images: [
        "icDailyTasks",
        "icDailyTasks"
    ])
}
