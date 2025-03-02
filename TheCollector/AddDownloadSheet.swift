//
//  Add.swift
//  TheCollector
//
//  Created by Stefano De Cillis on 28/02/25.
//

import SwiftData
import SwiftUI

struct AddDownloadSheet: View {

    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    @State private var shownAlert: Bool = false
    @EnvironmentObject var settings: GlobalSettings

    var body: some View {

        NavigationStack {
            VStack {
                Group {
                    caster
                    Divider()
                    blooming
                    quintet
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
    
    @ViewBuilder
    var blooming : some View {
        Button("Hololive - Blooming Radiance") {
            if !settings.bloomingLoaded {
                let res = expSheet(expName: "holo_bloomingRadiance")
                for card in res {
                    context.insert(card)
                }
                self.settings.bloomingLoaded.toggle()
                dismiss()
            } else {
                shownAlert = true
            }
        }.onAppear {
            let query01 = FetchDescriptor<Card>(predicate: #Predicate { $0.setName == "Blooming Radiance" })
            let count01 = (try? context.fetchCount(query01)) ?? 0
            if count01 > 0 {
                settings.bloomingLoaded = true
            }
        }.alert( "Already loaded this expansion", isPresented: $shownAlert) {
            Button("Try again"){
                // try again
            }
            Button("Delete", role: .destructive){
                // Delete
            }
            
            Button("Cancel", role: .cancel){}
        } message: {
            Text("You have already loaded this expansion! What would you like to do?")
        }
    }
    
    @ViewBuilder
    var caster : some View {
        Button("Caster") {
            // load caster.json
        }
    }
    
    @ViewBuilder
    var quintet : some View {
        Button("Hololive - Quintet Spectrum") {
            if !settings.quintetLoaded {
                let res = expSheet(expName: "holo_quintetSpectrum")
                for card in res {
                    context.insert(card)
                }
                self.settings.quintetLoaded.toggle()
                dismiss()
            } else {
                shownAlert = true
            }
        }.onAppear {
            let query02 = FetchDescriptor<Card>(predicate: #Predicate { $0.setName == "Quintet Spectrum" })
            let count02 = (try? context.fetchCount(query02)) ?? 0
            if count02 > 0 {
                settings.quintetLoaded = true
            }
        }.alert( "Already loaded this expansion", isPresented: $shownAlert) {
            Button("Try again"){
                // try again
            }
            Button("Delete", role: .destructive){
                // Delete
            }
            Button("Cancel", role: .cancel){}
        } message: {
            Text("You have already loaded this expansion! What would you like to do?")
        }

    }
}

