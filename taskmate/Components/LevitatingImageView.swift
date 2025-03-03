//
//  LevitatingImageView.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 16/12/24.
//

import SwiftUI

struct LevitatingImageView: View {
    
    private let name: String
    init(_ name: String) {
        self.name = name
    }
    
    @State private var isLevitating = false
    private let levitatingAnimation = Animation
        .easeInOut(duration: 2)
        .repeatForever(autoreverses: true)
    
    var body: some View {
        ZStack(alignment: .center) {
            Image(name)
                .resizable()
                .scaledToFit()
                .offset(y: isLevitating ? -10 : 10)
                .rotationEffect(.degrees(isLevitating ? 1 : -1))
                .scaleEffect(isLevitating ? 1 : 0.95)
                .animation(levitatingAnimation, value: isLevitating)
                .onAppear {
                    isLevitating = true
                }
        }
    }
}

#Preview {
    LevitatingImageView("icPlan")
}
