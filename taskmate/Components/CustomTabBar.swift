//
//  CustomTabBar.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 16/12/24.
//

import SwiftUI

typealias OnTabClick = (_ index: Int) -> Void

struct CustomTabItem {
    let title: String
    let icon: String
}

struct CustomTabBar: View {
    let currentIndex: Int
    let items: [CustomTabItem]
    let onTabClick: OnTabClick
    
    init(currentIndex: Int, items: [CustomTabItem], onTabClick: @escaping OnTabClick) {
        self.currentIndex = currentIndex
        self.items = items
        self.onTabClick = onTabClick
    }
    
    var lastIndex: Int {
        return items.count - 1
    }
    
    var body: some View {
        HStack(alignment: .center) {
            ForEach(Array(items.enumerated()), id: \.offset) {
                index, item in
                
                let isSelected = index == currentIndex
                
                Spacer()
                Button {
                    onTabClick(index)
                } label: {
                    Image(systemName: item.icon)
                        .font(.title)
                        .foregroundColor(isSelected ? .black : .white)
                }
                .background {
                    if isSelected {
                        Circle()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.white)
                    }
                }
                if index == lastIndex {
                    Spacer()
                }
            }
        }
        .frame(minWidth: 200, maxWidth: .infinity)
        .padding(.vertical, 30)
        .background(.black)
        .cornerRadius(30)
        //.padding(.horizontal, 10)
        //.padding(.bottom, UIApplication.getSafeAreaMargin())
    }
}

#Preview {
    CustomTabBar(currentIndex: 0, items: [
        CustomTabItem(title: "Home", icon: "house"),
        CustomTabItem(title: "Calendar", icon: "calendar"),
        CustomTabItem(title: "Home", icon: "plus")
    ]) { selection in
        
    }
}
