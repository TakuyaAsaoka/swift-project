//
//  ScheduleAppApp.swift
//  ScheduleApp
//
//  Created by AsaokaTakuya on 2023/06/15.
//

import SwiftUI

@main
struct ScheduleAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
