//
//  Profile.swift
//  MuscleUp
//
//  Created by Bryan Battu on 13/04/2024.
//

import SwiftUI

struct Profile: View {
    let stats: [[String]] = [
        ["91", "Nb de séances total"],
        ["1h15", "Temps moyen séance"],
        ["7000 Kgs", "Charge moyenne séance"],
        ["10", "Nb reps moyen / série"]
    ]
    
    let mensurations: [[String]] = [
        ["39 cm", "Tour de bras"],
        ["101 cm", "Tour de poitrine"],
        ["83,5 cm", "Tour de taille"],
        ["56 cm", "Tour de cuisse"]
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Bryan Battu")
                    .font(.title)
                    .bold()
                Image(systemName: "pencil")
                    .bold()
                Spacer()
                Image(systemName: "gearshape.fill")
            }
            Text("Membre depuis le 20 juin 2024")
                .font(.caption)
            Text("Mensurations")
                .font(.headline)
                .padding(.vertical, 8)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(mensurations, id: \.self) { item in
                    if item.count == 2 {
                        StatsCard(data: item[0], legend: item[1])
                    }
                }
            }
            Text("Statistiques")
                .font(.headline)
                .padding(.vertical, 8)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(stats, id: \.self) { item in
                    if item.count == 2 {
                        StatsCard(data: item[0], legend: item[1])
                    }
                }
            }
            Text("Historiques")
                .font(.headline)
                .padding(.vertical, 8)
            LazyVGrid(columns: [GridItem(.flexible())], spacing: 12, content: {
                HistoryCard(title: "Historique des séances")
                HistoryCard(title: "Historique des exercices")
            })
            Spacer()
        }
        .padding(20)
    }
}

#Preview {
    Profile()
}
