//
//  SessionViewModel.swift
//  MuscleUp
//
//  Created by Bryan Battu on 18/06/2024.
//

import Foundation
import RealmSwift

class SessionViewModel: MuscleUpViewModel {
    var request: Request?
    
    override init() {
        super.init()
        self.request = Request(viewModel: self)
    }
    
    func completeSeance() {
        guard let request = self.request else {
            return
        }
        
        let realm = try! Realm()
        
        guard let session = realm.objects(SessionRealmModel.self).first else {
            print("No session found in Realm database")
            return
        }
        
        var params = [String : Any]()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // Par exemple, pour obtenir un format ISO 8601
        let startDateString = dateFormatter.string(from: session.startDateTime)
        let endDateString = dateFormatter.string(from: .now)
        
        params["gymId"] = session.gymId
        params["startDate"] = startDateString
        params["endDate"] = endDateString
        
        var programSeances = [[String: Any]]()
        
        for exercise in session.exercises {
            var exerciseDict = [String: Any]()
            exerciseDict["exerciseId"] = exercise.exerciceId
            
            var seriesArray = [[String: Any]]()
            for serie in exercise.series {
                let serieDict: [String: Any] = [
                    "numberOfRep": serie.repetitionNumber,
                    "weight": serie.weight
                ]
                seriesArray.append(serieDict)
            }
            
            exerciseDict["series"] = seriesArray
            programSeances.append(exerciseDict)
        }
        
        params["programSeances"] = programSeances
        
        request.completeSeance(params: params) { [self] (response: MuscleUpResponse<CompleteSeanceModel>) in
            if let result = response.result {
                print(result.id)
                LoginManager().deleteAllSessions()
            }
        }
    }
    
    func getSeances(completion: @escaping ([SessionModel]) -> ()) {
        guard let request = request else {
            return
        }
        
        request.getSeances { (response: MuscleUpResponse<[SessionModel]>) in
            if let result = response.result {
                completion(result)
            }
        }
    }
}
