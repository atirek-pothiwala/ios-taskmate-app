//
//  CustomButton.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 16/12/24.
//

import SwiftUI

typealias OnCustomButtonClick = () -> Void

struct CustomButton: View {
    
    let title: String
    let imageName: String
    let backgroundColor: Color
    let foregroundColor: Color
    let onCustomButtonClick: OnCustomButtonClick
    
    init(
        title: String,
        imageName: String,
        backgroundColor: Color = .black,
        foregroundColor: Color = .white,
        onCustomButtonClick: @escaping OnCustomButtonClick
    ) {
        self.title = title
        self.imageName = imageName
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.onCustomButtonClick = onCustomButtonClick
    }
    
    var body: some View {
        Button {
            onCustomButtonClick()
        } label: {
            HStack {
                Text(title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                Spacer()
                ColorAnimationImageView(imageName: imageName)
            }
            .padding(.vertical, 25)
            .padding(.horizontal, 35)
        }
        .frame(minWidth: 200, maxWidth: .infinity)
        .foregroundColor(foregroundColor)
        .background(backgroundColor)
        .cornerRadius(30)
    }
}

#Preview {
    CustomButton(title: "Containue", imageName: "chevron.up.right.dotted.2") {
        debugPrint("Custom Button Event: On Click")
    }
}
