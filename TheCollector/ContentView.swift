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
                        //                        print("mi sono rotto le scatole")
                        let res = expSheet(expName: "holo-quintetSpectrum")
                        print(res.cardType)
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
        cardType: cardData.cards[0].cardType,
        name: cardData.cards[0].name,
        number: cardData.cards[0].number,
        color: cardData.cards[0].color ?? "type_void",
        image: cardData.cards[0].image ?? "",
        setName: cardData.cards[0].setName,
        rarity: "C",
        gameCode: "holo",
        expansionCode: "hBP02"
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
