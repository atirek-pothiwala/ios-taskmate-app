//
//  BlinkImageView.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 15/12/24.
//

import SwiftUI

struct ColorAnimationImageView: View {
    
    let imageName: String
    let duration: TimeInterval
    let fadeDuration: TimeInterval
    
    init(imageName: String, duration: TimeInterval = 2.0) {
        self.imageName = imageName
        self.duration = duration
        self.fadeDuration = duration / 4
    }
    
    private let colors: [Color] = [
        .white,
        .red,
        .blue,
        .green,
        .orange,
        .purple,
        .pink,
        .yellow,
    ]
    
    @State private var currentColorIndex = 0
    @State private var isFadingOut = false
        
    var body: some View {
        Image(systemName: self.imageName)
            .fontWeight(.bold)
            .font(.title)
            .foregroundColor(colors[currentColorIndex])
            .opacity(isFadingOut ? 0.0 : 1.0)
            .animation(.easeInOut(duration: fadeDuration), value: isFadingOut)
            .onAppear(perform: startColorChange)
    }
    
    private func startColorChange() {
        Timer.scheduledTimer(withTimeInterval: duration, repeats: true) {
            timer in
            
            toggleFadeAnimation()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + fadeDuration) {
                currentColorIndex = (currentColorIndex + 1) % colors.count
                
                toggleFadeAnimation()
            }
        }
    }
    
    private func toggleFadeAnimation() {
        withAnimation {
            isFadingOut = !isFadingOut
        }
    }
}

#Preview {
    ColorAnimationImageView(imageName: "chevron.up.right.dotted.2")
}
