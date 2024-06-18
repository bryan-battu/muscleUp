//
//  SerieDetail.swift
//  MuscleUp
//
//  Created by Bryan Battu on 06/06/2024.
//

import SwiftUI
import RealmSwift

struct SerieDetail: View {
    @ObservedRealmObject var serie: SerieRealmModel
    @State private var repetitions: String = ""
    @State private var weight: String = ""
    var serieIndex: Int
    
    var body: some View {
        HStack {
            Text("\(serieIndex)")
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            TextField("Répétitions", text: $repetitions)
                .keyboardType(.numberPad)
                .onAppear {
                    repetitions = String(serie.repetitionNumber)
                }
                .onSubmit {
                    saveSerie()
                }
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
            Spacer()
            TextField("Poids", text: $weight)
                .keyboardType(.decimalPad)
                .onAppear {
                    weight = String(serie.weight)
                }
                .onSubmit {
                    saveSerie()
                }
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 5)
        .cornerRadius(10)
        .frame(maxWidth: .infinity, minHeight: 30) // Ensure minimum height
    }
    
    private func saveSerie() {
        guard let repetitions = Int(repetitions), let weight = Float(weight) else { return }
        let realm = try! Realm()
        try! realm.write {
            serie.thaw()?.repetitionNumber = repetitions
            serie.thaw()?.weight = weight
        }
    }
}

#Preview {
    SerieDetail(serie: SerieRealmModel(), serieIndex: 1)
}
