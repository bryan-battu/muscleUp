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
        VStack {
            Text("Choisissez une salle")
                .fontWeight(.bold)
                .font(.title2)
            
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
                    GymList(gyms: $gyms, selectedGym: $selectedGym)
                }
            }
            
            GradientButton(title: "Démarrer", icon: "arrow.right") {
                var newSession = SessionRealmModel()
                guard let gymId = selectedGym?.id, let gymName = selectedGym?.name else {
                    return
                }
                
                newSession.gymId = gymId
                newSession.gymName = gymName
                newSession.startDateTime = Date()
                
                try? realm.write({
                    realm.add(newSession)
                })
            }
            .disableWithOpacity(selectedGym == nil)
        }
        .onAppear {
            gymViewModel.getMyGyms { gyms in
                isLoading = false
                self.gyms = gyms
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
                        .foregroundStyle(Color.green)
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
                selectedGym = gym
            }
        }
        .frame(height: 350)
        .listStyle(PlainListStyle())
        .background(Color.white)
        .padding()
    }
}
