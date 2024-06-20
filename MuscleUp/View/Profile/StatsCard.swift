//
//  StatsCard.swift
//  MuscleUp
//
//  Created by Bryan Battu on 20/06/2024.
//

import SwiftUI

struct StatsCard: View {
    
    var data: String
    var legend: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(data)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(legend)
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(15)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    Profile()
}
