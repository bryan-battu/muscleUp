//
//  AddExercices.swift
//  MuscleUp
//
//  Created by Bryan Battu on 10/04/2024.
//

import SwiftUI
import RealmSwift

struct AddExercices: View {
    var session: SessionRealmModel
    
    var body: some View {
        VStack {
            Text("Séance en cours - \(session.gymName)")
                .font(.title2)
                .fontWeight(.bold)
                .padding()
            Spacer()
        }
    }
}

#Preview {
    AddExercices(session: SessionRealmModel())
}
