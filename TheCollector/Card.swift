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
    var cardType: String
    var name: String
    var number: String
    var color: String
    var image: String
    var setName: String
    var rarity: String
    
    init(
        cardType: String,
        name: String,
        number: String,
        color: String,
        image: String,
        setName: String,
        rarity: String
    ) {
        self.cardType = cardType
        self.name = name
        self.number = number
        self.color = color
        self.image = image
        self.setName = setName
        self.rarity = rarity
    }
}
