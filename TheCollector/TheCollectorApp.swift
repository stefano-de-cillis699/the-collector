//
//  TheCollectorApp.swift
//  TheCollector
//
//  Created by Stefano De Cillis on 27/01/25.
//

import SwiftData
import SwiftUI

@main
struct TheCollectorApp: App {
    var settings = GlobalSettings()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: [Game.self, Card.self, Expansion.self])
            .environmentObject(settings)
    }
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}


