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
    var armSize: Double?
    var chestSize: Double?
    var waistSize: Double?
    var thighSize: Double?
    var gender: String?
    var createdAt: String?
    var updatedAt: String?
    
    private enum CodingKeys: String, CodingKey {
        case userId = "id"
        case firstname
        case lastname
        case email
        case visibility
        case armSize
        case chestSize
        case waistSize
        case thighSize
        case gender
        case createdAt
        case updatedAt
    }
}
