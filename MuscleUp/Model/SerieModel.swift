//
//  SerieModel.swift
//  MuscleUp
//
//  Created by Bryan Battu on 15/04/2024.
//

import Foundation
import RealmSwift

class SeriesRealmModel: Object, ObjectKeyIdentifiable {
    @Persisted var exerciceId: String = "" 
    @Persisted var repetitionNumber: Int = 0
    @Persisted var weight: Float = 0.0
}
