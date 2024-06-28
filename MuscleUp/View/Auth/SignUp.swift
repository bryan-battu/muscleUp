//
//  SignUp.swift
//  MuscleUp
//
//  Created by Bryan Battu on 14/01/2024.
//

import SwiftUI

struct SignUp: View {
    @Binding var showSignUp: Bool
    @ObservedObject var authViewModel: AuthViewModel
    
    enum Gender: String, CaseIterable, Identifiable {
        case male
        case female
        
        var id: String { self.rawValue }
        
        var displayName: String {
            switch self {
            case .male:
                return "Homme"
            case .female:
                return "Femme"
            }
        }
        
        var stringValue: String {
                switch self {
                case .male:
                    return "MALE"
                case .female:
                    return "FEMALE"
                }
            }
    }
    
    /// View properties
    @State private var emailID: String = ""
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var password: String = ""
    @State private var confirmedPassword: String = ""
    @State private var selectedGender: Gender = .male
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            Button {
                showSignUp = false
            } label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            }
            .padding(.top, 10)
            
            HeaderView(title: "Inscription", subtitle: "Inscrivez-vous pour continuer")
            
            VStack(spacing: 25) {
                CustomTextField(autocapitalizationType: .never, hint: "Email", value:  $emailID)
                
                CustomTextField(autocapitalizationType: .sentences, hint: "Prénom", value:  $firstname)
                
                CustomTextField(autocapitalizationType: .sentences, hint: "Nom", value:  $lastname)
                
                CustomTextField(autocapitalizationType: .never, hint: "Mot de passe", isPassword: true, value:  $password)
                
                CustomTextField(autocapitalizationType: .never, hint: "Confirmez votre mot de passe", isPassword: true, value:  $confirmedPassword)
                
                Picker("Gender", selection: $selectedGender) {
                    ForEach(Gender.allCases) { gender in
                        Text(gender.displayName).tag(gender)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                PrimaryButton(title: "S'inscrire", icon: "arrow.right") {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                    let params: [String : Any] = [
                        "email": emailID,
                        "firstname": firstname,
                        "lastname": lastname,
                        "password": password,
                        "confirmPassword": confirmedPassword,
                        "gender": selectedGender.stringValue
                    ]
                    
                    authViewModel.register(params: params)
                }
                .hSpacing(.trailing)
                // Désactiver tant que les fields ne sont pas remplis
                .disableWithOpacity(emailID.isEmpty || password.isEmpty || firstname.isEmpty || lastname.isEmpty || confirmedPassword.isEmpty)
            }
            .padding(.top, 20)
            
            Spacer(minLength: 0)
            
            HStack(spacing: 6, content: {
                Text("Vous avez déjà un compte ?")
                    .foregroundStyle(.gray)
                
                Button("Connectez-vous") {
                    showSignUp = false
                }
                .fontWeight(.bold)
                .tint(.blue)
            })
            .font(.callout)
            .hSpacing()
        })
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .toolbar(.hidden, for: .navigationBar)
    }
}


#Preview {
    ContentView()
}
