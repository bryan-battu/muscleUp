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
    let exercises = List<ExerciceRealmModel>()
}
