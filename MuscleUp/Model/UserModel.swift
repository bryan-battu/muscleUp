//
//  UserModel.swift
//  MuscleUp
//
//  Created by Bryan Battu on 28/03/2024.
//

import Foundation

struct UserModel: Codable {
    var userId: String
    var firstname: String?
    var lastname: String?
    var email: String?
    var visibility: String?
    
    private enum CodingKeys: String, CodingKey {
        case userId = "id"
        case firstname
        case lastname
        case email
        case visibility
    }
}
