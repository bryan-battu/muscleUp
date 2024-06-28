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
    
    @ObservedRealmObject var session: SessionRealmModel
    
    var body: some View {
        VStack {
            Text("Choisissez un exercice")
                .fontWeight(.bold)
                .font(.title2)
                .padding(.top, 20)
            
            Spacer()
            
            ExerciceList(exercices: $exercices, selectedExercice: $selectedExercice)
            
            PrimaryButton(title: "Ajouter", icon: "arrow.right") {
                var newExercice = ExerciceRealmModel()
                guard let exerciceName = selectedExercice?.name, let exerciceId = selectedExercice?.id else {
                    return
                }
                
                newExercice.exerciceName = exerciceName
                newExercice.exerciceId = exerciceId
                
                try? realm.write({
                    realm.add(newExercice)
                    $session.exercises.append(newExercice)
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
                Image(systemName: "figure.strengthtraining.traditional")
                    .foregroundColor(.white)
                Text(exercice.name)
                    .bold()
                    .padding(.horizontal, 5)
                    .foregroundColor(.white)
                Spacer()
                
                if selectedExercice == exercice {
                    Image(systemName: "checkmark")
                        .foregroundStyle(Color.white)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.black)
            .cornerRadius(8)
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .padding(.vertical, 5)
            .onTapGesture {
                if selectedExercice == exercice {
                    selectedExercice = nil
                } else {
                    selectedExercice = exercice
                }
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
