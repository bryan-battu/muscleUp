//
//  RankCard.swift
//  MuscleUp
//
//  Created by Bryan Battu on 03/07/2024.
//

import SwiftUI

struct RankCard: View {
    
    var category: String
    var rankMin: String
    var rankMax: String
    var percentageRank: Double
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text(category)
                Text(rankMin)
                    .font(.title)
                    .bold()
                HStack {
                    Image(rankMin)
                        .resizable()
                        .frame(width: 60, height: 60)
                    if (rankMin != "MASTER") {
                        ProgressView(value: percentageRank, total: 100)
                            .tint(.purple)
                        Image(rankMax)
                            .resizable()
                            .frame(width: 60, height: 60)
                    }
                }
            }
            Spacer()
        }
        .listRowSeparator(.hidden)
    }
}

#Preview {
    RankCard(category: "ASSIDUITÉ", rankMin: "IRON", rankMax: "BRONZE", percentageRank: 5)
}
