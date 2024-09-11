//
//  SessionHistory.swift
//  MuscleUp
//
//  Created by Bryan Battu on 29/08/2024.
//

import SwiftUI

struct SessionHistory: View {
    
    let sessionHistory: SessionModel
    
    var body: some View {
        Text("Poids total soulevé pendant la séance: \(String(format: "%.2f", sessionHistory.weight)) kg")
    }
}

#Preview {
    SessionHistory(sessionHistory: SessionModel(id: "1234", startDate: "03/04/2024", endDate: "03/04/2024", customer: UserModel(userId: "1234"), gym: GymModel(id: "1234", name: "sdcjb", groupName: "sdc", city: "sdc", department: "sdc", region: "sdc", country: "sdc"), score: 20.2, weight: 30.4, programSeances: [SessionDetailModel(id: "sdc", exercise: ExerciceModel(id: "", name: "", oneRepScore: 234, basicWeight: 234, weightMultiplier: 234, description: ""), series: [SerieModel(id: "", numberOfRep: 2, weight: 2)])]))
}
