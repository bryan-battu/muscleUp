//
//  ExerciceModel.swift
//  MuscleUp
//
//  Created by Bryan Battu on 15/04/2024.
//

import Foundation
import RealmSwift

class ExerciceRealmModel: Object {
    @Persisted var exerciceId: String = ""
    @Persisted var exerciceName: String = ""
    let series = List<SeriesRealmModel>()
}
