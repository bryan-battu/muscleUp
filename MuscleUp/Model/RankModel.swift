//
//  RankModel.swift
//  MuscleUp
//
//  Created by Bryan Battu on 03/07/2024.
//

import Foundation

struct RankModel: Codable {
    var category: String
    var score: Double
    var ranks: [RanksModel]
}


struct RanksModel: Codable {
    var id: String
    var grade: String
    var minScore: Double
}

struct TreatedRank: Codable, Identifiable, Hashable {
    var id = UUID()
    var category: String
    var rankMin: String
    var rankMax: String
    var percentageRank: Double
}
