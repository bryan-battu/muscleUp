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
        .foregroundColor(.white)
        .padding(15)
        .frame(maxWidth: .infinity)
        .background(Color.black)
        .cornerRadius(10)
    }
}

#Preview {
    Profile()
}
