//
//  ExercicesHistory.swift
//  MuscleUp
//
//  Created by Bryan Battu on 21/08/2024.
//

import SwiftUI

struct ExercicesHistory: View {
    
    var exerciceViewModel = ExerciceViewModel()
    @State var exercicesHistory: [ExerciceHistoryModel] = []
    
    func getMyExercices() {
        exerciceViewModel.getMyExercices { history in
            exercicesHistory = history
        } 
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(exercicesHistory, id: \.id) { exercice in
                    NavigationLink(destination: ExerciceHistory(history: exercice.history, exerciceName: exercice.name)) {
                        Text(exercice.name)
                            .bold()
                    }
                }
            }
            .listStyle(PlainListStyle())
            .background(Color.white)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Historique des exercices")
        .onAppear {
            getMyExercices()
        }
    }
}

#Preview {
    ExercicesHistory()
}
