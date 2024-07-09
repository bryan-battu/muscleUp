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
                    .font(.subheadline)
                Text(rankMin)
                    .font(.title2)
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
        .padding(10)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    RankCard(category: "ASSIDUITÉ", rankMin: "IRON", rankMax: "BRONZE", percentageRank: 5)
}
