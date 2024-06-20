//
//  HistoryCard.swift
//  MuscleUp
//
//  Created by Bryan Battu on 20/06/2024.
//

import SwiftUI

struct HistoryCard: View {
    
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            Image(systemName: "arrow.right")
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    Profile()
}
