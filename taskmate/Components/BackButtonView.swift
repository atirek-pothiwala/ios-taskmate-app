//
//  BackButtonView.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 18/12/24.
//

import SwiftUI

typealias OnBackButtonClick = () -> Void

struct BackButtonView: View {
    
    let title: String
    let onBackButtonClick: OnBackButtonClick
    
    init(title: String, onBackButtonClick: @escaping OnBackButtonClick) {
        self.title = title
        self.onBackButtonClick = onBackButtonClick
    }
    
    var body: some View {
        Button {
            onBackButtonClick()
        } label: {
            Image(systemName: "chevron.backward")
                .font(.title3)
                .fontWeight(.regular)
            
            Text(title)
                .font(.title3)
                .fontWeight(.regular)
        }.foregroundStyle(.black)

    }
}

#Preview {
    BackButtonView(title: "Go Back") {
        debugPrint("Back Button Event: On Click")
    }
}
