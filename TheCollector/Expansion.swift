//
//  Cards.swift
//  Holo
//
//  Created by Stefano De Cillis on 27/01/25.
//

import Foundation
import SwiftData

@Model
class Expansion {
    enum CodingKeys: CodingKey {
        case name
        case image
        case gameCode
    }

    var id = UUID()
    var name: String
    var image: String?
    var gameCode: String

    init(
        id: UUID = UUID(),
        name: String,
        image: String,
        gameCode: String
    ) {
        self.id = id
        self.name = name
        self.image = image
        self.gameCode = gameCode
    }
}
