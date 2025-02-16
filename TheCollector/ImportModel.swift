//
//  ImportModel.swift
//  TheCollector
//
//  Created by Stefano De Cillis on 14/02/25.
//

import Foundation

struct GameI: Codable, Identifiable {

    enum CodingKeys: CodingKey {
        case code
        case name
        case image
    }

    var id = UUID()
    var code: String
    var name: String
    var image: String

    init(
        id: UUID = UUID(),
        code: String,
        name: String,
        image: String
    ) {
        self.id = id
        self.code = code
        self.name = name
        self.image = image
    }
}

struct ExpansionI: Codable, Identifiable {

    enum CodingKeys: CodingKey {
        case name
        case image
        case gameCode
    }

    var id = UUID()
    var name: String
    var image: String?
    var gameCode: Int?

    init(
        id: UUID = UUID(),
        name: String,
        image: String,
        gameCode: Int
    ) {
        self.id = id
        self.name = name
        self.image = image
        self.gameCode = gameCode
    }
}

struct CardI: Codable, Identifiable {

    enum CodingKeys: CodingKey {
        case cardType
        case name
        case number
        case color
        case image
        case setName
    }

    var id = UUID()
    var cardType: String
    var name: String
    var number: String
    var color: String? = "type_void"
    var image: String?
    var setName: String
    var rarity: String = "C"
    var gameCode: Int?
    var expansionId: Int?

    init(
        id: UUID = UUID(),
        cardType: String,
        name: String,
        number: String,
        color: String,
        image: String,
        setName: String,
        rarity: String,
        gameCode: Int,
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
        self.gameCode = gameCode
        self.expansionId = expansionId
    }
}

class ReadData: ObservableObject {
    @Published var games = [GameI]()
    @Published var cards = [CardI]()
    @Published var expansions = [ExpansionI]()

    init() {

    }

    func loadGameData() {
        guard
            let url = Bundle.main.url(
                forResource: "games", withExtension: "json")
        else {
            print("File not found")
            return
        }

        let data = try? Data(contentsOf: url)
        let games = try? JSONDecoder().decode([GameI].self, from: data!)
        self.games = games!

    }

    func loadExpansionData() {
        guard
            let url = Bundle.main.url(
                forResource: "expansions", withExtension: "json")
        else {
            print("File not found")
            return
        }

        let data = try? Data(contentsOf: url)
        let expansions = try? JSONDecoder().decode([ExpansionI].self, from: data!)
        self.expansions = expansions!

    }

    func loadCardData(_ expansion: String) {
        guard
            let url = Bundle.main.url(
                forResource: expansion, withExtension: "json")
        else {
            print("File not found")
            return
        }

        let data = try? Data(contentsOf: url)
        let cards = try? JSONDecoder().decode([CardI].self, from: data!)
        self.cards = cards!

    }
}
