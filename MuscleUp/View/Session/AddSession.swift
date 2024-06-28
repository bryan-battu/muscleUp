//
//  AddSession.swift
//  MuscleUp
//
//  Created by Bryan Battu on 09/04/2024.
//

import SwiftUI
import RealmSwift

struct AddSession: View {
    @Environment(\.realm) var realm

    @ObservedObject var gymViewModel: GymViewModel
    
    @State private var gyms: [GymModel] = []
    @State private var isLoading = true
    @State private var selectedGym: GymModel?
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    if isLoading {
                        ProgressView()
                            .padding()
                    } else {
                        if gyms.isEmpty {
                            Text("Aucune salle n'est disponible. Ajoutez une salle.")
                                .foregroundColor(.gray)
                                .padding()
                                .multilineTextAlignment(.center)
                        } else {
                            Text("Choisir une salle")
                                .font(.title3)
                            GymList(gyms: $gyms, selectedGym: $selectedGym)
                                .frame(height: geometry.size.height / 3)
                        }
                        
                        HStack {
                            Rectangle().fill(Color.black).frame(height: 1)
                            Text("OU")
                            Rectangle().fill(Color.black).frame(height: 1)
                        }

                        Spacer()
                        
                        NfcButton {
                            
                        }
                        
                        Spacer()
                    }
                    
                    PrimaryButton(title: "Démarrer", icon: "arrow.right") {
                        let newSession = SessionRealmModel()
                        guard let gymId = selectedGym?.id, let gymName = selectedGym?.name else {
                            return
                        }
                        
                        newSession.gymId = gymId
                        newSession.gymName = gymName
                        newSession.startDateTime = Date()
                        newSession.exercises = List<ExerciceRealmModel>()
                        
                        try? realm.write({
                            realm.add(newSession)
                        })
                    }
                    .disableWithOpacity(selectedGym == nil)
                }
                .navigationTitle("Démarrer une séance")
                .padding()
                .onAppear {
                    gymViewModel.getMyGyms { gyms in
                        isLoading = false
                        self.gyms = gyms
                    }
                }
            }
        }
    }
}

#Preview {
    AddSession(gymViewModel: GymViewModel())
}

struct GymList: View {
    @Binding var gyms: [GymModel]
    @Binding var selectedGym: GymModel?
    
    var body: some View {
        List(gyms, id: \.id) { gym in
            HStack {
                VStack(alignment: .leading) {
                    Text(gym.name)
                        .fontWeight(.bold)
                        .font(.headline)
                    Text(gym.city)
                        .font(.subheadline)
                }
                Spacer()
                if selectedGym == gym {
                    Image(systemName: "checkmark")
                        .foregroundStyle(Color.white)
                }
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(10)
            .background(Color.black)
            .cornerRadius(8)
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .onTapGesture {
                if selectedGym == gym {
                    selectedGym = nil
                } else {
                    selectedGym = gym
                }
            }
        }
        .listRowSpacing(10)
        .listStyle(PlainListStyle())
        .background(Color.white)
    }
}
