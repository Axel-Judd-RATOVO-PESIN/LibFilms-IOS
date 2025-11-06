//
//  MovieCardViewModel.swift
//  DesignSystem
//
//  Created by Axel .RP on 05/11/2025.
//

import Foundation

public struct MovieCardViewModel {
    public let title: String
    public let details: String // ex: "D. Villeneuve (2021)"
    
    // On le crée à partir du Model de l'app
    // Note: On va devoir définir MovieModel à l'avance (voir phase 3)
    // Pour l'instant, on peut utiliser des strings
    public init(title: String, details: String) {
        self.title = title
        self.details = details
    }
}
