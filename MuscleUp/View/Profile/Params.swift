//
//  Parameters.swift
//  MuscleUp
//
//  Created by Bryan Battu on 27/06/2024.
//

import SwiftUI

struct Params: View {
    
    func openMail() {
        let url = URL(string: "message://")
        if let url = url {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            LazyVGrid(columns: [GridItem(.flexible())], spacing: 12, content: {
                Button(action: openMail, label: {
                    ListCard(title: "Contacter le support")
                })
                
                NavigationLink(destination: MyGyms()) {
                    ListCard(title: "Gérer mes salles")
                }
                .tint(.black)
                
            })
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Paramètres")
        .padding(20)
    }
}

#Preview {
    Params()
}
