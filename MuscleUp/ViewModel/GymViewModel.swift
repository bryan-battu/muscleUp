//
//  GymViewModel.swift
//  MuscleUp
//
//  Created by Bryan Battu on 23/03/2024.
//

import Foundation

class GymViewModel: MuscleUpViewModel {
    var request: Request?
    
    override init() {
        super.init()
        self.request = Request(viewModel: self)
    }
    
    func getGyms(completion: @escaping ([GymModel]) -> ()) {
        guard let request = self.request else {
            return
        }
        
        request.getGyms { (response: MuscleUpResponse<[GymModel]>) in
            if let result = response.result {
                completion(result)
            }
        }
    }
    
    func getMyGyms(completion: @escaping ([GymModel]) -> ()) {
        guard let request = self.request else {
            return
        }
        
        request.getMyGyms { (response: MuscleUpResponse<[GymModel]>) in
            if let result = response.result {
                completion(result)
            }
        }
    }
    
    func signUpToGym(params: [String : Any], completion: @escaping (SignUpToGymModel) -> ()) {
        guard let request = self.request else {
            return
        }
        
        request.signUpToGym(params: params) { (response: MuscleUpResponse<SignUpToGymModel>) in
            if let result = response.result {
                completion(result)
            }
        }
    }
}
