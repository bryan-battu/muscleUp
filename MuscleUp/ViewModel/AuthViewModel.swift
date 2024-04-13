//
//  AuthViewModel.swift
//  MuscleUp
//
//  Created by Bryan Battu on 28/02/2024.
//

import Foundation

class AuthViewModel: MuscleUpViewModel {
    var request: Request?
    
    override init() {
        super.init()
        self.request = Request(viewModel: self)
    }
    
    @Published var isLoggedIn = false
    
    func register(params: [String : Any]) {
        guard let request = self.request else {
            return
        }
        
        request.register(params: params) { [self] (response: MuscleUpResponse<RegisterModel>) in
            if let token = response.result?.token {
                LoginManager.shared.saveAccessToken(accessToken: token)
                
                request.getMe { (response: MuscleUpResponse<UserModel>) in
                    let result = response.result
                    
                    if let id = result?.userId, let firstname = result?.firstname, let lastname = result?.lastname, let email = result?.email, let visibility = result?.visibility {
                        let user = UserModel(userId: id, firstname: firstname, lastname: lastname, email: email, visibility: visibility)
                        
                        LoginManager.shared.setUser(user: user)
                        
                        self.isLoggedIn = true
                    } else {
                        showErrorToast(message: "Une erreur est survenue")
                    }
                }
            } else {
                showErrorToast(message: "Une erreur est survenue")
            }
        }
    }
    
    func login(params: [String : Any]) {
        guard let request = self.request else {
            return
        }
        
        request.login(params: params) { [self] (response: MuscleUpResponse<LoginModel>) in
            if let token = response.result?.token {
                LoginManager.shared.saveAccessToken(accessToken: token)
                
                request.getMe { (response: MuscleUpResponse<UserModel>) in
                    print("laaaaaa")
                    let result = response.result
                    
                    if let id = result?.userId, let firstname = result?.firstname, let lastname = result?.lastname, let email = result?.email, let visibility = result?.visibility {
                        let user = UserModel(userId: id, firstname: firstname, lastname: lastname, email: email, visibility: visibility)
                        
                        LoginManager.shared.setUser(user: user)
                        
                        self.isLoggedIn = true
                    } else {
                        showErrorToast(message: "Une erreur est survenue")
                    }
                }
            } else {
                showErrorToast(message: "Une erreur est survenue")
            }
        }
    }
}
