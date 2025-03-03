//
//  View+Extension.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 23/12/24.
//

import SwiftUICore

extension View {
    
    func toResizableSheet(height: Binding<CGFloat>) -> some View {
        return self.overlay {
            GeometryReader { geometry in
                Color.clear.preference(key: InnerHeightPreferenceKey.self, value: geometry.size.height)
            }
        }
        .onPreferenceChange(InnerHeightPreferenceKey.self) { newHeight in
            height.wrappedValue = newHeight
        }
        .presentationDetents([.height(height.wrappedValue)])
    }
}

private struct InnerHeightPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
