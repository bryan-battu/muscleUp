//
//  Home.swift
//  MuscleUp
//
//  Created by Bryan Battu on 28/02/2024.
//

import SwiftUI

struct Root: View {
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        TabView() {
            Color.green
                .tabItem {
                    Text("Accueil")
                    Image(systemName: "house")
                        .foregroundColor(.primary)
                }
            Session()
                .tabItem {
                    Text("Séance")
                    Image(systemName: "plus.app")
                        .foregroundColor(.primary)
                }
            Profile()
                .tabItem {
                    Text("Profil")
                    Image(systemName: "person.circle")
                        .foregroundColor(.primary)
                }
        }
        .accentColor(colorScheme == .dark ? .white : .black)
    }
}

#Preview {
    Root()
}
