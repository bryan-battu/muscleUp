//
//  ExerciceModel.swift
//  MuscleUp
//
//  Created by Bryan Battu on 15/04/2024.
//

import Foundation
import RealmSwift

class ExerciceRealmModel: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var exerciceId: String
    @Persisted(originProperty: "exercises") var session: LinkingObjects<SessionRealmModel>
    @Persisted var exerciceName: String = ""
    @Persisted var series: List<SerieRealmModel>
}

struct ExerciceModel: Codable, Equatable {
    let id: String
    let name: String
    let oneRepScore: Double
    let basicWeight: Double
    let weightMultiplier: Double
    let description: String
}
