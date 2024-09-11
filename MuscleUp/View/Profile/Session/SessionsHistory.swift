//
//  SessionHistory.swift
//  MuscleUp
//
//  Created by Bryan Battu on 21/08/2024.
//

import SwiftUI

struct SessionsHistory: View {
    
    var sessionViewModel = SessionViewModel()
    @State var sessionsHistory: [SessionModel] = []
    
    func getSeances() {
        sessionViewModel.getSeances { history in
            sessionsHistory = history
        }
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(sessionsHistory, id: \.id) { session in
                    if let date = convertToDate(session.startDate) {
                        NavigationLink(destination: SessionHistory(sessionHistory: session)) {
                            Text("Séance du \(date)")
                                .bold()
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .background(Color.white)

            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Historique des séances")
        .onAppear {
            getSeances()
        }
    }
}

#Preview {
    SessionsHistory()
}
