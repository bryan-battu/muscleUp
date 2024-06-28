//
//  MyGyms.swift
//  MuscleUp
//
//  Created by Bryan Battu on 28/06/2024.
//

import SwiftUI

struct MyGyms: View {
    @State private var gyms: [GymModel] = []
    @State private var selectedGym: GymModel?
    
    @State var presentAddGymSheet: Bool = false
    
    @ObservedObject var gymViewModel: GymViewModel = GymViewModel()
    
    var body: some View {
        VStack {
            GymList(gyms: $gyms, selectedGym: $selectedGym)
            PrimaryButton(title: "Ajouter une salle") {
                presentAddGymSheet = true
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Gérer mes salles")
        .onAppear {
            gymViewModel.getMyGyms { gyms in
                self.gyms = gyms
            }
        }
        .sheet(isPresented: $presentAddGymSheet, onDismiss: {
            gymViewModel.getMyGyms { gyms in
                self.gyms = gyms
            }
            presentAddGymSheet = false
        }, content: {
            AddGym()
        })
    }
}

#Preview {
    MyGyms()
}
