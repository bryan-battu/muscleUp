//
//  GymModel.swift
//  MuscleUp
//
//  Created by Bryan Battu on 23/03/2024.
//

import Foundation

struct GymModel: Codable, Equatable {
    let id: String
    let name: String
    let groupName: String
    let city: String
    let department: String
    let region: String
    let country: String
}

struct SignUpToGymModel: Codable {    
    let id: String
    let customer: UserModel
    let gym: GymModel
    let date: String
}
