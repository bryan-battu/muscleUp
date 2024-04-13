//
//  Session.swift
//  MuscleUp
//
//  Created by Bryan Battu on 23/03/2024.
//

import SwiftUI
import RealmSwift

struct Session: View {
    @ObservedResults(SessionRealmModel.self) var sessions
    var gymViewModel = GymViewModel()
    
    var body: some View {
        if sessions.count > 0 {
            AddExercices(gymId: sessions[0].gymId, gymName: sessions[0].gymName)
        } else {
            AddSession(gymViewModel: gymViewModel)
        }
    }
}

#Preview {
    Session()
}
