//
//  AddGym.swift
//  MuscleUp
//
//  Created by Bryan Battu on 28/06/2024.
//

import SwiftUI

struct AddGym: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var gyms: [GymModel] = []
    @State private var selectedGym: GymModel?
    
    @ObservedObject var gymViewModel: GymViewModel = GymViewModel()
    
    var body: some View {
        VStack {
            Text("Choisissez une salle")
                .fontWeight(.bold)
                .font(.title2)
                .padding(.top, 20)
            
            GymList(gyms: $gyms, selectedGym: $selectedGym)
            PrimaryButton(title: "Ajouter") {
                guard let selectedGym = selectedGym else {
                    return
                }
                
                let params: [String : Any] = [
                    "id": selectedGym.id
                ]
                
                gymViewModel.signUpToGym(params: params) { response in
                    self.dismiss()
                }
            }
            .disableWithOpacity(selectedGym == nil)
        }
        .padding()
        .onAppear {
            gymViewModel.getGyms { gyms in
                self.gyms = gyms
            }
        }
    }
}

#Preview {
    AddGym()
}
