//
//  Cards.swift
//  Holo
//
//  Created by Stefano De Cillis on 27/01/25.
//

import Foundation
import SwiftData

@Model
class Game {
    enum CodingKeys: CodingKey {
        case name
        case image
    }
    
    var id = UUID()
    var name: String
    var image: String
    
    init(
        id: UUID = UUID(),
        name: String,
        image: String
    ) {
        self.id = id
        self.name = name
        self.image = image
    }
}
