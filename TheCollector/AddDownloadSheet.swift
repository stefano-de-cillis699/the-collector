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
    @State private var shownAlertQ: Bool = false
    @State private var shownAlertB: Bool = false
    @State private var shownAlertC: Bool = false
    @EnvironmentObject var settings: GlobalSettings
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Group {
                    caster
                    blooming
                    quintet
                }
            }.buttonStyle(.borderedProminent)
                .navigationTitle("Download Cards")
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
        let bloomingRadiance = "Blooming Radiance"
        Button("Hololive - Blooming Radiance") {
            if !settings.bloomingLoaded {
                let res = expSheet(expName: "holo_bloomingRadiance")
                for card in res {
                    context.insert(card)
                }
                do{
                    try context.save()
                }catch{
                    print("failed to save")
                }
                self.settings.bloomingLoaded.toggle()
                dismiss()
            } else {
                shownAlertB = true
            }
        }.onAppear {
            let query01 = FetchDescriptor<Card>(
                predicate: #Predicate { $0.setName == bloomingRadiance
                })
            let count01 = (try? context.fetchCount(query01)) ?? 0
            if count01 > 0 {
                settings.bloomingLoaded = true
            }
        }.alert( "Already loaded this expansion", isPresented: $shownAlertB) {
            Button("Try again"){
                // try again
            }
            Button("Delete", role: .destructive){
                deleteExp(expToDelete: bloomingRadiance)
            }
            
            Button("Cancel", role: .cancel){}
        } message: {
            Text(
                "You have already loaded this expansion! What would you like to do?"
            )
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
        let quintetSpectrum = "Quintet Spectrum"
        Button("Hololive - Quintet Spectrum") {
            if !settings.quintetLoaded {
                let res = expSheet(expName: "holo_quintetSpectrum")
                for card in res {
                    context.insert(card)
                }
                do{
                    try context.save()
                }catch{
                    print("Failed to save")
                }
                
                self.settings.quintetLoaded.toggle()
                dismiss()
            } else {
                shownAlertQ = true
            }
        }.onAppear {
            let query02 = FetchDescriptor<Card>(
                predicate: #Predicate { $0.setName == quintetSpectrum
                })
            let count02 = (try? context.fetchCount(query02)) ?? 0
            if count02 > 0 {
                settings.quintetLoaded = true
            }
        }.alert( "Already loaded this expansion", isPresented: $shownAlertQ) {
            Button("Try again"){
                // try again
            }
            Button("Delete", role: .destructive){
                deleteExp(expToDelete: quintetSpectrum)
            }
            Button("Cancel", role: .cancel){}
        } message: {
            Text(
                "You have already loaded this expansion! What would you like to do?"
            )
        }
        
    }
    
    func deleteExp(expToDelete: String){
        if expToDelete.isEmpty { return }
        print(expToDelete)
        do{
            try context
                .delete(
                    model: Card.self,
                    where: #Predicate { $0.setName == expToDelete
                    })
            try context.save()
            let queryTest = FetchDescriptor<Card>(
                predicate: #Predicate { $0.setName == expToDelete
                })
            let countTest = (try? context.fetchCount(queryTest)) ?? 0
            print(countTest)
            if(countTest == 0){
                switch expToDelete {
                    case "Quintet Spectrum":
                        settings.quintetLoaded = false
                        dismiss()
                    case "Blooming Radiance":
                        settings.bloomingLoaded = false
                        dismiss()
                    default:
                        print("default")
                        break
                }
            }else{
                print("Something went wrong with the deletion")
            }
            
        }catch{
            print("failed to delete")
        }
    }
}

