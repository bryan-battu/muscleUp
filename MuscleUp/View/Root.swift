//
//  Home.swift
//  MuscleUp
//
//  Created by Bryan Battu on 28/02/2024.
//

import SwiftUI

class TabViewModel: ObservableObject {
    @Published var selectedTab: Int = 0
}

struct Root: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var tabViewModel = TabViewModel()

    var body: some View {
        TabView(selection: $tabViewModel.selectedTab) {
            Home()
                .tabItem {
                    Text("Accueil")
                    Image(systemName: "house")
                }
                .tag(0)
            Session()
                .tabItem {
                    Text("Séance")
                    Image(systemName: "dumbbell")
                }
                .tag(1)
            Profile()
                .tabItem {
                    Text("Profil")
                    Image(systemName: "person.circle")
                }
                .tag(2)
        }
        .accentColor(.black)
    }
}

#Preview {
    Root()
}
