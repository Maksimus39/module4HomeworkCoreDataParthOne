//
//  module4HomeworkCoreDataParthOneApp.swift
//  module4HomeworkCoreDataParthOne
//
//  Created by Максим Минаков on 07.06.2026.
//

import SwiftUI
import CoreData

@main
struct module4HomeworkCoreDataParthOneApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
