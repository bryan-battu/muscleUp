//
//  SessionDetail.swift
//  MuscleUp
//
//  Created by Bryan Battu on 10/04/2024.
//

import SwiftUI
import RealmSwift
import AlertToast

struct SessionDetail: View {
    @ObservedRealmObject var session: SessionRealmModel
    var exerciceViewModel = ExerciceViewModel()
    var sessionViewModel = SessionViewModel()
    @State private var showingSheet = false
    @State private var showToast: Bool = false
    @State private var showDisconnectToast: Bool = false

    var body: some View {
        VStack {
            HStack {
                PrimaryButton(title: "Annuler", little: true, danger: true) {
                    LoginManager().deleteAllSessions()
                }
                
                Spacer()
                
                PrimaryButton(title: "Terminer", little: true) {
                    sessionViewModel.completeSeance()
                }
            }
            .padding(.horizontal)
            
            
            List(session.exercises, id: \.id) { exercice in
                ExerciceDetail(exercice: exercice, showToast: $showToast, showDisconnectToast: $showDisconnectToast)
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .listStyle(PlainListStyle())
            .background(Color.white)
            .toast(isPresenting: $showToast) {
                AlertToast(displayMode: .hud, type: .regular, title: "Connexion à l'haltère ...")
            }
            .toast(isPresenting: $showDisconnectToast) {
                AlertToast(displayMode: .hud, type: .regular, title: "Déconnexion de l'haltère ...")
            }
            
            
            PrimaryButton(title: "Ajouter un exercice", icon: "dumbbell.fill") {
                showingSheet = true
            }
            .sheet(isPresented: $showingSheet) {
                AddExercice(exerciceViewModel: exerciceViewModel, session: session)
            }
            .padding(.bottom)
            Spacer()
        }
    }
}

#Preview {
    SessionDetail(session: SessionRealmModel())
}
