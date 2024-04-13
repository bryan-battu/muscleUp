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
    
    func getGyms() {
        guard let request = self.request else {
            return
        }
        
        request.getGyms { (response: MuscleUpResponse<GymModel>) in
            
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
}
