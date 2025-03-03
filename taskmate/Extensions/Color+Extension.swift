//
//  Color+Extension.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 17/12/24.
//

import Foundation
import SwiftUI

extension Color {
    
    static func gradient(colors: [Color],
                               startPoint: UnitPoint = .topLeading,
                               endPoint: UnitPoint = .bottomTrailing) -> LinearGradient {
        return LinearGradient(
            colors: colors,
            startPoint: startPoint,
            endPoint: endPoint
        )
    }
}
