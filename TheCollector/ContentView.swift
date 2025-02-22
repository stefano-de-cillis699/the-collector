//  ContentView.swift
//  TheCollector
//
//
//  Created by Stefano De Cillis on 27/01/25.
//

import SwiftData
import SwiftUI

struct CardsView: View {
    @State var detail: Card? = nil
    @State private var isShowingDownloadSheet = false
    @Query() var cards: [Card]

    var cardGrid: some View {
        NavigationStack {
            ScrollView {
                let columns = [GridItem(.flexible()), GridItem(.flexible())]
                LazyVGrid(columns: columns) {
                    ForEach(cards) { card in
                        VStack {
                            Image(card.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .onTapGesture {
                                    detail = card
                                }
                            Text(card.name)
                        }
                    }
                }.padding(10)
                    .navigationTitle("Cards")
                    .navigationBarTitleDisplayMode(.large)
                    .toolbar {
                        if !cards.isEmpty {
                            Button("Add Card") {
                                isShowingDownloadSheet.toggle()
                            }.sheet(isPresented: $isShowingDownloadSheet) {
                                AddDownloadSheet()
                            }
                        }
                    }
            }
        }.overlay {
            if cards.isEmpty {
                ContentUnavailableView(
                    label: {
                        Label(
                            "No Cards yet",
                            systemImage:
                                "list.bullet.rectangle.portrait"
                        )
                    },
                    description: {
                        Text(
                            "Download your first expansion to start building your collection"
                        )
                    },
                    actions: {
                        Button("Download more cards") {
                            isShowingDownloadSheet.toggle()
                        }.sheet(isPresented: $isShowingDownloadSheet) {
                            AddDownloadSheet()
                        }
                    }
                )
            }
        }
    }

    @ViewBuilder
    var detailsView: some View {
        if let d = detail {
            Image(d.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .padding(20)
                .onTapGesture {
                    detail = nil
                }
        }
    }

    var body: some View {
        cardGrid
        detailsView
    }
}

struct AddDownloadSheet: View {

    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss

    @State private var cardType: String = "Oshi"
    @State private var name: String = "name"
    @State private var number: String = "H34"
    @State private var color: String = "red"
    @State private var image: String = "hBP02-001_OSR"
    
    var body: some View {
        NavigationStack {
            VStack {
                Group {
                    Button("Caster") {
                        // load caster.json
                    }
                    Divider()
                    Button("Hololive - Blooming Radiance") {
                        // load bloomingRadiance.json
                    }
                    Button("Hololive - Quintet Spectrum") {
                        let res = expSheet(expName: "holo-quintetSpectrum")
                        
//                        let cardSet = Card(
//                            cardType: "card",
//                            name: "name",
//                            number: "number",
//                            color: "olo",
//                            image: "imsgr",
//                            setName: "Holo Qintet"
//                            rarity: "C",
//                            gameCode: "holo",
//                            expansionCode: "hBP02"
//                        )
//                        print(res.cardType)
//                        print(res.name)
//                        print(res.number)
//                        print(res.color)
//                        print(res.image)
//                        print(res.rarity)
//                        print(res.setName)
//                        print(res.gameCode)
//                        print(res.expansionCode)
//                        context.insert(cardSet)
                        context.insert(res)
                        dismiss()
                    }
                }.buttonStyle(.borderedProminent)
            }.navigationTitle("Download Cards")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .topBarLeading) {
                        Button("Cancel") { dismiss() }
                    }
                }
        }
    }
}

func expSheet(expName: String) -> Card {
    @ObservedObject var cardData: ReadCardData

    let test = ReadCardData.ExpansionSet(expName: expName)
    cardData = ReadCardData(expansion: test)

    let cardSet = Card(
        cardType: cardData.cards[9].cardType,
        name: cardData.cards[9].name,
        number: cardData.cards[9].number,
        color: cardData.cards[9].color ?? "type_void",
        image: cardData.cards[9].image ?? "",
        setName: cardData.cards[9].setName
//        rarity: "C",
//        gameCode: "holo",
//        expansionCode: "hBP02"
    )
    return cardSet

}

struct ContentView: View {
    var body: some View {
        CardsView()
    }

}

#Preview {
    ContentView()
}
