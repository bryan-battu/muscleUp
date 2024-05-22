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
    @ObservedResults(ExerciceRealmModel.self) var exercises
    @State private var showingSheet = false
    
    var body: some View {
        VStack {
            Text("Séance en cours - \(session.gymName)")
                .font(.title2)
                .fontWeight(.bold)
                .padding()
            
            List(exercises, id: \.id) { exercice in
                HStack {
                    Text(exercice.exerciceName)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .padding(.vertical, 5)
            }
            .listStyle(PlainListStyle())
            .background(Color.white)
            .padding()
            
            GradientButton(title: "Ajouter un exercice", icon: "dumbbell.fill") {
                showingSheet = true
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
