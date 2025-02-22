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
        case gameCode
        case expansionCode
    }
    
    var id = UUID()
    var cardType: String
    var name: String
    var number: String
    var color: String
    var image: String
    var setName: String
    var rarity: String
    var gameCode: String
    var expansionCode: String
    
    init(
        id: UUID = UUID(),
        cardType: String,
        name: String,
        number: String,
        color: String,
        image: String,
        setName: String,
        rarity: String,
        gameCode: String,
        expansionCode: String
    ) {
        self.id = id
        self.cardType = cardType
        self.name = name
        self.number = number
        self.color = color
        self.image = image
        self.setName = setName
        self.rarity = rarity
        self.gameCode = gameCode
        self.expansionCode = expansionCode
    }
}
