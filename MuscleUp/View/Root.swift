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
                    Image(systemName: "house")
                        .foregroundColor(.primary)
                }
            Session()
                .tabItem {
                    Image(systemName: "plus.app")
                        .foregroundColor(.primary)
                }
            Color.blue
                .tabItem {
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
