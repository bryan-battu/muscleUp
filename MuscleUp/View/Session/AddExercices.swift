//
//  AddExercices.swift
//  MuscleUp
//
//  Created by Bryan Battu on 10/04/2024.
//

import SwiftUI

struct AddExercices: View {
    var gymId: String
    var gymName: String
    
    var body: some View {
        VStack {
            Text("Séance en cours - \(gymName)")
                .font(.title2)
                .fontWeight(.bold)
                .padding()
            Spacer()
        }
    }
}

#Preview {
    AddExercices(gymId: "azerty", gymName: "Basic Fit")
}
