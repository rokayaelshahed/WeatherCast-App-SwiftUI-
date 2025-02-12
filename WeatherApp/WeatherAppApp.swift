//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Rokaya El Shahed on 12/02/2025.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
