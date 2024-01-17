//
//  GroceryGoApp.swift
//  GroceryGo
//
//  Created by İrem Sever on 15.01.2024.
//

import SwiftUI

@main
struct GroceryGoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
