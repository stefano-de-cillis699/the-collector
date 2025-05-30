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
    
//    static var descriptor: FetchDescriptor<Card> {
//        var descriptor = FetchDescriptor<Card>(sortBy: [SortDescriptor(\.number, order: .reverse)])
//        descriptor.fetchLimit = 10
//        return descriptor
//    }
    
    @Query(sort: \Card.number) var cards: [Card]
    @EnvironmentObject var settings: GlobalSettings
    
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
                            Text(card.name + " (" + card.rarity + ")")
                            Text(card.setName).font(.caption)
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

func expSheet(expName: String) -> [Card] {
    @ObservedObject var cardData: ReadCardData

    let test = ReadCardData.ExpansionSet(expName: expName)
    cardData = ReadCardData(expansion: test)

    var cardSet: [Card] = []

    for card in cardData.cards {
        cardSet.append(
            Card(
                cardType: card.cardType,
                name: card.name,
                number: card.number,
                color: card.color ?? "type_void",
                image: card.image ?? "",
                setName: card.setName,
                rarity: card.rarity,
                gameCode: String(expName.prefix(4)),
                expansionCode: String(card.number.split(separator: "-")[0])
            )
        )
    }
    return cardSet

}

struct ContentView: View {
    var body: some View {
        CardsView()
    }

}

#Preview {
    @Previewable @EnvironmentObject var settings: GlobalSettings
    ContentView()
}
