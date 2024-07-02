//
//  UserViewModel.swift
//  MuscleUp
//
//  Created by Bryan Battu on 26/06/2024.
//

import Foundation

class UserViewModel: MuscleUpViewModel {
    var request: Request?
    
    override init() {
        super.init()
        self.request = Request(viewModel: self)
    }
    
    func getMe(completion: @escaping (UserModel) -> ()) {
        guard let request = self.request else {
            return
        }
        
        request.getMe { (response: MuscleUpResponse<UserModel>) in
            if let result = response.result {
                completion(result)
            }
        }
    }
    
    func getStats(completion: @escaping (StatModel) -> ()) {
        guard let request = self.request else {
            return
        }
        
        request.getStat { (response: MuscleUpResponse<StatModel>) in
            if let result = response.result {
                completion(result)
            }
        }
    }
    
    func updateMe(params: [String : Any], completion: @escaping (UserModel) -> ()) {
        guard let request = self.request else {
            return
        }
        
        request.updateMe(params: params) { (response: MuscleUpResponse<UserModel>) in
            if let result = response.result {
                completion(result)
            }
        }
    }
}
