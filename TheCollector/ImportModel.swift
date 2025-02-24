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
    var image: String?

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
        case code
        case name
        case image
        case gameCode
    }

    var id = UUID()
    var code: String
    var name: String
    var image: String?
    var gameCode: String

    init(
        id: UUID = UUID(),
        code: String,
        name: String,
        image: String,
        gameCode: String
    ) {
        self.id = id
        self.code = code
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
        case rarity
    }

    var id = UUID()
    var cardType: String
    var name: String
    var number: String
    var color: String? = "type_void"
    var image: String?
    var setName: String
    var rarity: String
    var gameCode: String = "xx"
    var expansionCode: String = "xx"

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

class ReadData: ObservableObject {
    @Published var games = [GameI]()
    @Published var expansions = [ExpansionI]()

    init() {
        loadGameData()
        loadExpansionData()
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
        let expansions = try? JSONDecoder().decode(
            [ExpansionI].self, from: data!)
        self.expansions = expansions!

    }

}

class ReadCardData: ObservableObject {
    @Published var cards = [CardI]()
    @Published var expansionName: ExpansionSet

    struct ExpansionSet {
        let expName: String
    }

    init(expansion: ExpansionSet) {
        self.expansionName = expansion
        loadCardData(expansion.expName)
    }

    func loadCardData(_ expName: String) {

        if expName != "" {
            guard
                let url = Bundle.main.url(
                    forResource: expName, withExtension: "json")
            else {
                print("File not found")
                return
            }

            let data = try? Data(contentsOf: url)
            let cards = try? JSONDecoder().decode([CardI].self, from: data!)
            self.cards = cards!
        } else {
            self.cards = []
        }

    }
}
