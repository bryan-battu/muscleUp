//
//  SessionModel.swift
//  MuscleUp
//
//  Created by Bryan Battu on 09/04/2024.
//

import Foundation
import RealmSwift

class SessionRealmModel: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var gymId: String
    @Persisted var gymName: String
    @Persisted var startDateTime: Date
    @Persisted var exercises: List<ExerciceRealmModel>
}

struct CompleteSeanceModel: Codable {
    let id: String
}

struct SessionModel: Codable {
    let id: String
    let startDate: String
    let endDate: String
    let customer: UserModel
    let gym: GymModel
    let score: Float
    let weight: Float
    let programSeances: [SessionDetailModel]
}

struct SessionDetailModel: Codable {
    let id: String
    let exercise: ExerciceModel
    let series: [SerieModel]
}
