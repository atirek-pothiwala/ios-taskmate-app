//
//  FilterView.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 16/12/24.
//

import SwiftUI

typealias OnFilterClick = (_ index: Int) -> Void

struct FilterView: View {
    
    let currentIndex: Int
    let items: [String]
    let onFilterClick: OnFilterClick
    
    init(currentIndex: Int, items: [String], onFilterClick: @escaping OnFilterClick) {
        self.currentIndex = currentIndex
        self.items = items
        self.onFilterClick = onFilterClick
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(Array(items.enumerated()), id: \.offset) {
                    index, item in

                    let isSelected = index == currentIndex
                    Button {
                        self.onFilterClick(index)
                    } label: {
                        Text(item)
                            .font(.title3)
                            .fontWeight(.regular)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 12)
                    }
                    .background {
                        if isSelected {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.black)
                        } else {
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder(lineWidth: 1)
                        }
                    }
                    .foregroundColor(isSelected ? .white : .black)
                    
                }
            }
        }
    }
}

#Preview {
    FilterView(
        currentIndex: 0, items: ["To Do", "In Progress", "Done"]) {
            index in
            debugPrint("Index: \(index)")
        }
}
