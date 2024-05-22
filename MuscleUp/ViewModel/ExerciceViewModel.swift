//
//  ExerciceViewModel.swift
//  MuscleUp
//
//  Created by Bryan Battu on 20/05/2024.
//

import Foundation

class ExerciceViewModel: MuscleUpViewModel {
    var request: Request?
    
    override init() {
        super.init()
        self.request = Request(viewModel: self)
    }
    
    func getExercices(completion: @escaping ([ExerciceModel]) -> ()) {
        guard let request = self.request else {
            return
        }
        
        request.getExercices { (response: MuscleUpResponse<[ExerciceModel]>) in
            if let result = response.result {
                completion(result)
            }
        }
    }
}

