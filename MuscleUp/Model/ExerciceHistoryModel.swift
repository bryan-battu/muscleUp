//
//  ExericeHistoryModel.swift
//  MuscleUp
//
//  Created by Bryan Battu on 21/08/2024.
//

import Foundation

struct ExerciceHistoryModel: Codable {
    let id: String
    let name: String
    let history: [History]
}

struct History: Codable, Hashable {
    let weight: Float
    let date: String
}
