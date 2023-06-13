//
//  CalenderAppApp.swift
//  CalenderApp
//
//  Created by AsaokaTakuya on 2023/06/13.
//

import SwiftUI

@main
struct CalenderAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
