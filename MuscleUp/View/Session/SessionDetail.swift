//
//  SessionDetail.swift
//  MuscleUp
//
//  Created by Bryan Battu on 10/04/2024.
//

import SwiftUI
import RealmSwift

struct SessionDetail: View {
    var session: SessionRealmModel
    var exerciceViewModel = ExerciceViewModel()
    
    @State private var showingSheet = false
    
    var body: some View {
        VStack {
            Text("Séance en cours - \(session.gymName)")
                .font(.title2)
                .fontWeight(.bold)
                .padding()
            
            GradientButton(title: "Ajouter un exercice", icon: "dumbbell.fill") {
                showingSheet = true
//                var newSession = SessionRealmModel()
//                guard let gymId = selectedGym?.id, let gymName = selectedGym?.name else {
//                    return
//                }
//                
//                newSession.gymId = gymId
//                newSession.gymName = gymName
//                newSession.startDateTime = Date()
//                
//                try? realm.write({
//                    realm.add(newSession)
//                })
            }
            .sheet(isPresented: $showingSheet) {
                AddExercice(exerciceViewModel: exerciceViewModel, session: session)
            }
            Spacer()
        }
    }
}

#Preview {
    SessionDetail(session: SessionRealmModel())
}
