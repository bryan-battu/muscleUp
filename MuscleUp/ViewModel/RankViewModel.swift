//
//  RankViewModel.swift
//  MuscleUp
//
//  Created by Bryan Battu on 03/07/2024.
//

import Foundation

class RankViewModel: MuscleUpViewModel {
    var request: Request?
    
    override init() {
        super.init()
        self.request = Request(viewModel: self)
    }
    
    func getRank(completion: @escaping ([RankModel]) -> ()) {
        guard let request = request else {
            return
        }
        
        request.getRank { (response: MuscleUpResponse<[RankModel]>) in
            if let result = response.result {
                completion(result)
            }
        }
    }
}
