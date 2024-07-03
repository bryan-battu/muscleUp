//
//  Home.swift
//  MuscleUp
//
//  Created by Bryan Battu on 13/04/2024.
//

import SwiftUI

struct Home: View {
    
    var rankViewModel = RankViewModel()
    
    @State private var ranks: [RankModel] = []
    @State private var sortedRank: [TreatedRank] = []
    @State private var selectedRankIndex = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $selectedRankIndex) {
                    ForEach(0..<sortedRank.count, id: \.self) { index in
                        Text(sortedRank[index].category).tag(index)
                    }
                }
                .pickerStyle(.segmented)
                if !sortedRank.isEmpty {
                    RankCard(
                        category: sortedRank[selectedRankIndex].category,
                        rankMin: sortedRank[selectedRankIndex].rankMin,
                        rankMax: sortedRank[selectedRankIndex].rankMax,
                        percentageRank: sortedRank[selectedRankIndex].percentageRank
                    )
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .listStyle(PlainListStyle())
                    .background(Color.white)
                }
            }
            .navigationTitle("Accueil")
        }
        .onAppear {
            rankViewModel.getRank { result in
                ranks = result
                getRankAndProgression()
            }
        }
    }
    
    func getRankAndProgression() {
        sortedRank = []
        for rank in ranks {
            let sortedRanks = rank.ranks.sorted(by: { $0.minScore < $1.minScore })
            let score = rank.score
            
            var rankMin = "IRON"
            var rankMax = "N/A"
            var nextGradeMinScore = 0.0
            
            for (index, rank) in sortedRanks.enumerated() {
                if score < rank.minScore {
                    if index > 0 {
                        rankMin = sortedRanks[index - 1].grade
                        rankMax = rank.grade
                        nextGradeMinScore = rank.minScore
                    }
                    break
                } else if index == sortedRanks.count - 1 {
                    rankMin = rank.grade
                    rankMax = "N/A"
                }
            }
            
            // Calculate progress percentage within the current grade
            let previousGradeMinScore = sortedRanks.first { $0.grade == rankMin }?.minScore ?? 0.0
            let percentageRank = (score - previousGradeMinScore) / (nextGradeMinScore - previousGradeMinScore) * 100
            
            sortedRank.append(TreatedRank(category: rank.category, rankMin: rankMin, rankMax: rankMax, percentageRank: percentageRank))
        }
    }
}

#Preview {
    Home()
}
