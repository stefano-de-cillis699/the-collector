//
//  TheCollectorApp.swift
//  TheCollector
//
//  Created by Stefano De Cillis on 27/01/25.
//

import SwiftUI
import SwiftData

@main
struct TheCollectorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: Card.self)
    }
}
