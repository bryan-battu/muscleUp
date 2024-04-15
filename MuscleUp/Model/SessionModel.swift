//
//  SessionModel.swift
//  MuscleUp
//
//  Created by Bryan Battu on 09/04/2024.
//

import Foundation
import RealmSwift

class SessionRealmModel: Object, ObjectKeyIdentifiable {
    @Persisted var gymId: String
    @Persisted var gymName: String
    let exercises = List<ExerciceRealmModel>()
}
