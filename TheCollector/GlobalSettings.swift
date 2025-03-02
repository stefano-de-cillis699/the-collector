//
//  GlobalSettings.swift
//  TheCollector
//
//  Created by Stefano De Cillis on 28/02/25.
//

import SwiftUI
import SwiftData

class GlobalSettings: ObservableObject {
    @Published var bloomingLoaded: Bool = false
    @Published var quintetLoaded: Bool = false
}
