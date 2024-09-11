//
//  Date.swift
//  MuscleUp
//
//  Created by Bryan Battu on 29/08/2024.
//

import Foundation

func convertToDate(_ dateString: String) -> String? {
    let isoDateFormatter = DateFormatter()
    isoDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
    isoDateFormatter.locale = Locale(identifier: "en_US_POSIX")

    // Convertir la chaîne ISO en objet Date
    if let date = isoDateFormatter.date(from: dateString) {
        // Crée un autre DateFormatter pour obtenir le format jour/mois/année
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "dd/MM/yyyy"
        
        // Convertir la date en chaîne avec le nouveau format
        let formattedDateString = outputDateFormatter.string(from: date)
        print(formattedDateString) // Affiche: 03/07/2024
        return formattedDateString
    } else {
        return nil
        print("Format de date invalide")
    }
}
