//
//  Rank.swift
//  MuscleUp
//
//  Created by Bryan Battu on 04/07/2024.
//

import Foundation

enum CategoryTraduction: String, Codable {
    case assiduity = "ASSIDUITY"
    case performance = "PERFORMANCE"
    
    var frenchTranslation: String {
        switch self {
        case .assiduity:
            return "ASSIDUITÉ"
        case .performance:
            return "PERFORMANCE"
        }
    }
}
