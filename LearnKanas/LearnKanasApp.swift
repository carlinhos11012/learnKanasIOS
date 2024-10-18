//
//  LearnKanasApp.swift
//  LearnKanas
//
//  Created by user266820 on 10/16/24.
//

import SwiftUI
import CoreData

@main
struct YourApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

