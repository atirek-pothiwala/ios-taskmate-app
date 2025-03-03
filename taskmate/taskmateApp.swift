//
//  taskmateApp.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 15/12/24.
//

import SwiftUI

@main
struct taskmateApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LoginPage().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
