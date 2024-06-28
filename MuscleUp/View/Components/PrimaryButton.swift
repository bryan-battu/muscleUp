//
//  PrimaryButton.swift
//  MuscleUp
//
//  Created by Bryan Battu on 14/01/2024.
//

import SwiftUI

struct PrimaryButton: View {
    var title: String
    var icon: String?
    var little: Bool?
    var danger: Bool?
    var onClick: () -> ()
      
    var body: some View {
        Button {
            onClick()
        } label: {
            HStack(spacing: 15, content: {
                Text(title)
                if let icon = icon {
                    Image(systemName: icon)
                }
            })
            .fontWeight(little ?? false ? nil : .bold)
            .foregroundStyle(danger ?? false ? .red : .white)
            .padding(.vertical, little ?? false ? 5 : 12)
            .padding(.horizontal, little ?? false ? 15 : 35)
            .background(.black)
        }
        .cornerRadius(8)
    }
}

#Preview {
    ContentView()
}