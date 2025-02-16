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

    struct AddDownloadSheet: View {

        @Environment(\.dismiss) private var dismiss
        @Environment(\.modelContext) var context

        @State private var cardType: String = "Oshi"
        @State private var name: String = "BANANA22"
        @State private var number: String = "H34"
        @State private var color: String = "red"
        @State private var image: String = "hBP02-001_OSR"
        @State private var setName: String = "quintet"
        @State private var rarity: String = "OSR"

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
                        Button("Hololive - Quintet Specrum") {
                            
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

    var body: some View {
        cardGrid
        detailsView
    }
}

struct ContentView: View {
    var body: some View {
        CardsView()
    }

}

#Preview {
    ContentView()
}
