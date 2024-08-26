//
//  ExerciceHistory.swift
//  MuscleUp
//
//  Created by Bryan Battu on 21/08/2024.
//

import SwiftUI
import Charts

struct ExerciceHistory: View {
    let history: [History]
    let exerciceName: String
    
    var body: some View {
        VStack {
            Spacer()
            GroupBox("Historique - \(exerciceName)") {
                Chart {
                    ForEach(history, id: \.date) { histo in
                        if let date = convertToDate(histo.date) {
                            BarMark(
                                x: .value("Date", date),
                                y: .value("Poids", histo.weight)
                            )
                            .foregroundStyle(Color.black)
                        }
                    }
                }
            }
            .frame(height: 500)
            .padding()
            Spacer()
        }
    }
    
    func convertToDate(_ dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        return formatter.date(from: dateString)
    }
}

#Preview {
    ExerciceHistory(history: [History(weight: 30.0, date: "2024-07-03T17:26:42.000+00:00")], exerciceName: "Développé couché")
}
