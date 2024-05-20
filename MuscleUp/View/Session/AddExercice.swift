//
//  AddExercice.swift
//  MuscleUp
//
//  Created by Bryan Battu on 20/05/2024.
//

import SwiftUI
import RealmSwift

struct AddExercice: View {
    @Environment(\.realm) var realm
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var exerciceViewModel: ExerciceViewModel
    
    @State private var exercices: [ExerciceModel] = []
    @State private var selectedExercice: ExerciceModel?
    
    var session: SessionRealmModel
    
    var body: some View {
        VStack {
            Text("Choisissez un exercice")
                .fontWeight(.bold)
                .font(.title2)
                .padding(.top, 20)
            
            Spacer()
            
            ExerciceList(exercices: $exercices, selectedExercice: $selectedExercice)
            
            GradientButton(title: "Ajouter", icon: "arrow.right") {
                var newExercice = ExerciceRealmModel()
                guard let exerciceId = selectedExercice?.id, let exerciceName = selectedExercice?.name else {
                    return
                }
                
                newExercice.sessionId = session.id.stringValue
                newExercice.exerciceId = exerciceId
                newExercice.exerciceName = exerciceName
                
                try? realm.write({
                    realm.add(newExercice)
                })
                dismiss()
            }
            .disableWithOpacity(selectedExercice == nil)
        }
        .onAppear {
            exerciceViewModel.getExercices { exercices in
                //isLoading = false
                self.exercices = exercices
            }
        }
    }
}

struct ExerciceList: View {
    
    @Binding var exercices: [ExerciceModel]
    @Binding var selectedExercice: ExerciceModel?
    
    var body: some View {
        List(exercices, id: \.id) { exercice in
            HStack {
                HStack {
                    Image(systemName: "figure.strengthtraining.traditional")
                    Text(exercice.name)
                        .bold()
                        .padding(.horizontal, 5)
                    Spacer()
                    
                    if selectedExercice == exercice {
                        Image(systemName: "checkmark")
                            .foregroundStyle(Color.green)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(10)
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .padding(.vertical, 5)
            .onTapGesture {
                selectedExercice = exercice
            }
        }
        .listStyle(PlainListStyle())
        .background(Color.white)
        .padding()
    }
}

#Preview {
    AddExercice(exerciceViewModel: ExerciceViewModel(), session: SessionRealmModel())
}
