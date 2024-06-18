//
//  Request.swift
//  MuscleUp
//
//  Created by Bryan Battu on 28/02/2024.
//

import Foundation
import Alamofire

protocol ErrorHandler: AnyObject {
    func showErrorToast(message: String)
}

class Request {
    
    let viewModel: any ErrorHandler
    
    init(viewModel: any ErrorHandler) {
        self.viewModel = viewModel
    }
    
    let urlMuscleUp = "https://thomasdubuis.alwaysdata.net/api/v1.0"
    
    let endPointRegister = "/auth/register"
    let endPointLogin = "/auth/authenticate"
    let endPointGetGyms = "/user/getGyms"
    let endPointGetMyGyms = "/user/getMyGyms"
    let endPointGetMe = "/user/getMe"
    let endPointGetExercices = "/user/getExercises"
    let endPointCompleteSeance = "/user/completeSeance"
    
    func register<T : Codable>(params : [String : Any], completion: @escaping (MuscleUpResponse<T>) -> ()) {
        postMethod(params: params, endpoint: endPointRegister, completion: completion)
    }
    
    func login<T : Codable>(params : [String : Any], completion: @escaping (MuscleUpResponse<T>) -> ()) {
        postMethod(params: params, endpoint: endPointLogin, completion: completion)
    }
    
    func getGyms<T: Codable>(completion: @escaping (MuscleUpResponse<T>) -> ()) {
        getMethod(endpoint: endPointGetGyms, completion: completion)
    }
    
    func getMyGyms<T: Codable>(completion: @escaping (MuscleUpResponse<T>) -> ()) {
        getMethod(endpoint: endPointGetMyGyms, completion: completion)
    }
    
    func getMe<T: Codable>(completion: @escaping (MuscleUpResponse<T>) -> ()) {
        getMethod(endpoint: endPointGetMe, completion: completion)
    }
    
    func getExercices<T: Codable>(completion: @escaping (MuscleUpResponse<T>) -> ()) {
        getMethod(endpoint: endPointGetExercices, completion: completion)
    }
    
    func completeSeance<T: Codable>(params : [String : Any], completion: @escaping (MuscleUpResponse<T>) -> ()) {
        postMethod(params: params, endpoint: endPointCompleteSeance, completion: completion)
    }
    
    func postMethod<T : Codable>(params : Parameters, endpoint : String, completion: @escaping (MuscleUpResponse<T>) -> ()) {
        let url = urlMuscleUp + endpoint

        var headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        if let accessToken = LoginManager.shared.getSavedAccessToken() {
            headers["Authorization"] = "Bearer \(accessToken)"
        }

        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any?] else {
                        self.viewModel.showErrorToast(message: "Une erreur est survenue")
                        return
                    }
                    guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                        self.viewModel.showErrorToast(message: "Une erreur est survenue")
                        return
                    }
                    guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                        self.viewModel.showErrorToast(message: "Une erreur est survenue")
                        return
                    }
                    
                    print("⬅️ Response \(endpoint): \(prettyPrintedJson)")
                    
                    let r1 = Data("\(prettyPrintedJson)".utf8)
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(MuscleUpResponse<T>.self, from: r1)
                    
                    if !response.success {
                        if (response.displayError != nil) && (response.displayError == true) {
                            if let message = response.errorMessage {
                                self.viewModel.showErrorToast(message: message)
                            } else {
                                self.viewModel.showErrorToast(message: "Une erreur est survenue")
                            }
                        } else {
                            self.viewModel.showErrorToast(message: "Une erreur est survenue")
                        }
                    } else {
                        completion(response)
                    }
                } catch {
                    self.viewModel.showErrorToast(message: "Une erreur est survenue")
                    return
                }
            case .failure(let error):
                self.viewModel.showErrorToast(message: "Une erreur est survenue")
                return
            }
        }
    }
    
    func getMethod<T : Codable>(params : Parameters? = nil, endpoint : String, completion: @escaping (MuscleUpResponse<T>) -> ()) {
        let url = urlMuscleUp + endpoint

        var headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        if let accessToken = LoginManager.shared.getSavedAccessToken() {
            headers["Authorization"] = "Bearer \(accessToken)"
        }
        
        AF.request(url, method: .get, parameters: params, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any?] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                        print("Error: Cannot convert JSON object to Pretty JSON data")
                        return
                    }
                    guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                        print("Error: Could print JSON in String")
                        return
                    }
                    
                    print("⬅️ Response \(endpoint): \(prettyPrintedJson)")
                    
                    let r1 = Data("\(prettyPrintedJson)".utf8)
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(MuscleUpResponse<T>.self, from: r1)
                    
                    if !response.success {
                        if (response.displayError != nil) && (response.displayError == true) {
                            if let message = response.errorMessage {
                                self.viewModel.showErrorToast(message: message)
                            } else {
                                self.viewModel.showErrorToast(message: "Une erreur est survenue")
                            }
                        } else {
                            self.viewModel.showErrorToast(message: "Une erreur est survenue")
                        }
                    } else {
                        completion(response)
                    }
                } catch {
                    self.viewModel.showErrorToast(message: "Une erreur est survenue")
                    return
                }
            case .failure(let error):
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 403:
                        NotificationCenter.default.post(name: Notification.Name("UnauthorizedAccess"), object: nil)
                    default:
                        break;
                    }
                }
                self.viewModel.showErrorToast(message: "Une erreur est survenue")
                return
            }
        }
    }
}
