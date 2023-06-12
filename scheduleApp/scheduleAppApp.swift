//
//  scheduleAppApp.swift
//  scheduleApp
//
//  Created by TakuyaAsaoka on 2023/06/12.
//

import SwiftUI

@main
struct scheduleAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
