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
        case gameId
    }

    var id = UUID()
    var name: String
    var image: String?
    var gameId: Int

    init(
        id: UUID = UUID(),
        name: String,
        image: String,
        gameId: Int
    ) {
        self.id = id
        self.name = name
        self.image = image
        self.gameId = gameId
    }
}
