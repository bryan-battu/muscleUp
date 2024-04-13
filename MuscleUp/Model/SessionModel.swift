//
//  SessionModel.swift
//  MuscleUp
//
//  Created by Bryan Battu on 09/04/2024.
//

import Foundation
import RealmSwift

class SessionRealmModel: Object, ObjectKeyIdentifable {
    @Persisted var gymId: String
    @Persisted var gymName: String
}
