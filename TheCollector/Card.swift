//
//  Cards.swift
//  Holo
//
//  Created by Stefano De Cillis on 27/01/25.
//

import Foundation
import SwiftData

@Model
class Card {
    enum CodingKeys : CodingKey {
        case cardType
        case name
        case number
        case color
        case image
        case setName
        case rarity
        case gameId
        case expansionId
    }
    
    var id = UUID()
    var cardType: String
    var name: String
    var number: String
    var color: String
    var image: String
    var setName: String
    var rarity: String
    var gameId: Int
    var expansionId: Int
    
    init(
        id: UUID = UUID(),
        cardType: String,
        name: String,
        number: String,
        color: String,
        image: String,
        setName: String,
        rarity: String,
        gameId: Int,
        expansionId: Int
    ) {
        self.id = id
        self.cardType = cardType
        self.name = name
        self.number = number
        self.color = color
        self.image = image
        self.setName = setName
        self.rarity = rarity
        self.gameId = gameId
        self.expansionId = expansionId
    }
}
