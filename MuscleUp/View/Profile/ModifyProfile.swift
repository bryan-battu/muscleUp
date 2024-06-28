//
//  ModifyProfile.swift
//  MuscleUp
//
//  Created by Bryan Battu on 26/06/2024.
//

import SwiftUI

struct ModifyProfile: View {
    @Environment(\.dismiss) var dismiss
    
    var userViewModel = UserViewModel()
        
    /// View properties
    @State var firstname: String
    @State var lastname: String
    @State var armSize: String
    @State var chestSize: String
    @State var waistSize: String
    @State var thighSize: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            HStack {
                Text("Mettre à jour mon profil")
                    .font(.title)
                    .bold()
                
                Spacer()
            }
            
            VStack {
                HeaderTextField(name: "Prénom")
                CustomTextField(autocapitalizationType: .sentences, hint: "Prénom", value:  $firstname)
                    .padding(.bottom)
                
                HeaderTextField(name: "Nom")
                CustomTextField(autocapitalizationType: .sentences, hint: "Nom", value:  $lastname)
                    .padding(.bottom)
                
                HeaderTextField(name: "Tour de bras")
                CustomTextField(autocapitalizationType: .sentences, hint: "Tour de bras", value:  $armSize)
                    .padding(.bottom)
                
                HeaderTextField(name: "Tour de poitrine")
                CustomTextField(autocapitalizationType: .sentences, hint: "Tour de poitrine", value:  $chestSize)
                    .padding(.bottom)
                
                HeaderTextField(name: "Tour de taille")
                CustomTextField(autocapitalizationType: .sentences, hint: "Tour de taille", value:  $waistSize)
                    .padding(.bottom)
                
                HeaderTextField(name: "Tour de cuisse")
                CustomTextField(autocapitalizationType: .sentences, hint: "Tour de cuisse", value:  $thighSize)
                    .padding(.bottom)
                
                PrimaryButton(title: "Mettre à jour", icon: "arrow.right") {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                    let params: [String : Any] = [
                        "firstname": firstname,
                        "lastname": lastname,
                        "armSize": armSize,
                        "chestSize": chestSize,
                        "waistSize": waistSize,
                        "thighSize": thighSize
                    ]
                    
                    userViewModel.updateMe(params: params) { user in
                        self.dismiss()
                    }
                }
                .hSpacing(.trailing)
                // Désactiver tant que les fields ne sont pas remplis
                .disableWithOpacity(firstname.isEmpty || lastname.isEmpty)
            }
            .padding(.top, 20)
            
            Spacer(minLength: 0)
        })
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .toolbar(.hidden, for: .navigationBar)
        
    }
}

#Preview {
    ModifyProfile(firstname: "Bryan", lastname: "Battu", armSize: "38.5", chestSize: "101.0", waistSize: "83.5", thighSize: "56.0")
}

struct HeaderTextField: View {
    
    var name: String
    
    var body: some View {
        HStack {
            Text(name)
                .font(.subheadline)
                .bold()
                .foregroundStyle(.gray)
            Spacer()
        }
    }
}
