//
//  Constants.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 16/12/24.
//

import Foundation
import SwiftUICore
import UIKit

class Constants {
    
    static let allTasks = [
        TaskModel(id: "1",
                  title: "Production Bug",
                  description: "#bug",
                  color: Color.red.opacity(0.15),
                  priority: "High",
                  scheduleDate: "Sept 10 - 20, 2024",
                  status: 2
                 ),
        TaskModel(id: "2",
                  title: "KT Session",
                  description: "#ktsession",
                  color: Color.green.opacity(0.15),
                  priority: "Low",
                  scheduleDate: "Nov 12 - 22, 2024",
                  status: 0
                 ),
        TaskModel(id: "3",
                  title: "C'z Pro App",
                  description: "#uidesign",
                  color: Color.blue.opacity(0.15),
                  priority: "Medium",
                  scheduleDate: "Oct 08 - 20, 2024",
                  status: 1
                 ),
        TaskModel(id: "4",
                  title: "Coupon Distribution",
                  description: "#architecture",
                  color: Color.yellow.opacity(0.15),
                  priority: "Medium",
                  scheduleDate: "Oct 20 - 25, 2024",
                  status: 0
                 ),
        TaskModel(id: "5",
                  title: "Big Query",
                  description: "#prototype",
                  color: Color.orange.opacity(0.15),
                  priority: "Medium",
                  scheduleDate: "Oct 20 - 25, 2024",
                  status: 0
                 )
    ]    
}
