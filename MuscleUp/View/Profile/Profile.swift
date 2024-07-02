//
//  Profile.swift
//  MuscleUp
//
//  Created by Bryan Battu on 13/04/2024.
//

import SwiftUI

struct Profile: View {
    
    var userViewModel = UserViewModel()
    
    @State var presentEditProfilSheet: Bool = false
    
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var armSize: String = ""
    @State private var chestSize: String = ""
    @State private var waistSize: String = ""
    @State private var thighSize: String = ""
    @State private var email: String = ""
    @State private var totalSeance: Int = 0
    @State private var averageSeanceTime: Double = 0
    @State private var averageSeanceWeight: Double = 0
    @State private var averageSeriesRep: Double = 0
    
    func getMe() {
        userViewModel.getMe { user in
            if let firstnameResult = user.firstname, let lastnameResult = user.lastname {
                firstname = firstnameResult
                lastname = lastnameResult
            }
            
            if let armSizeResult = user.armSize {
                armSize = String(armSizeResult)
            }
            
            if let chestSizeResult = user.chestSize {
                chestSize = String(chestSizeResult)
            }
            
            if let waistSizeResult = user.waistSize {
                waistSize = String(waistSizeResult)
            }
            
            if let thighSizeResult = user.thighSize {
                thighSize = String(thighSizeResult)
            }
            
            if let emailResult = user.email {
                email = emailResult
            }
        }
    }
    
    func getStats() {
        userViewModel.getStats { stat in
            if let totalSeanceResult = stat.totalSeance {
                totalSeance = totalSeanceResult
            }
            
            if let averageSeanceTimeResult = stat.averageSeanceTime {
                averageSeanceTime = averageSeanceTimeResult
            }
            
            if let averageSeanceWeightResult = stat.averageSeanceWeight {
                averageSeanceWeight = averageSeanceWeightResult
            }
            
            if let averageSeriesRepResult = stat.averageSeriesRep {
                averageSeriesRep = averageSeriesRepResult
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Text("\(firstname) \(lastname)")
                        .font(.title3)
                        .bold()
                    Button(action: {
                        presentEditProfilSheet = true
                    }, label: {
                        Image(systemName: "pencil")
                            .bold()
                    })
                    
                    Spacer()
                    NavigationLink(destination: Params()) {
                        Image(systemName: "gearshape.fill")
                    }
                    .tint(.black)
                }
                Text("Membre depuis le 20 juin 2024")
                    .font(.caption)
                Text("Mensurations")
                    .font(.headline)
                    .padding(.vertical, 8)
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    StatsCard(data: armSize, legend: "Tour de bras")
                    StatsCard(data: chestSize, legend: "Tour de poitrine")
                    StatsCard(data: waistSize, legend: "Tour de taille")
                    StatsCard(data: thighSize, legend: "Tour de cuisse")
                }
                
                Text("Statistiques")
                    .font(.headline)
                    .padding(.vertical, 8)
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    StatsCard(data: String(totalSeance), legend: "Nb de séances total")
                    StatsCard(data: String(averageSeanceTime), legend: "Temps moyen séance")
                    StatsCard(data: String(averageSeanceWeight), legend: "Charge moyenne séance")
                    StatsCard(data: String(averageSeriesRep), legend: "Nb reps moyen / série")
                }
                Text("Historiques")
                    .font(.headline)
                    .padding(.vertical, 8)
                LazyVGrid(columns: [GridItem(.flexible())], spacing: 12, content: {
                    ListCard(title: "Historique des séances")
                    ListCard(title: "Historique des exercices")
                })
                Spacer()
            }
            .navigationTitle("Profil")
            .toolbar(content: {
                
            })
            .padding(.horizontal, 20)
            .onAppear {
                getMe()
                getStats()
            }
            .sheet(isPresented: $presentEditProfilSheet, onDismiss: {
                getMe()
                presentEditProfilSheet = false
            }, content: {
                ModifyProfile(firstname: firstname, lastname: lastname, armSize: armSize, chestSize: chestSize, waistSize: waistSize, thighSize: thighSize)
            })
        }
    }
}

#Preview {
    Profile()
}
