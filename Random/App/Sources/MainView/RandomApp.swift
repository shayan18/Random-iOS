//
//  RandomApp.swift
//  Random
//
//  Created by Shayan Ali on 01.02.23.
//

import SwiftUI

@main
struct RandomApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
