//
//  MovieDetailViewModel.swift
//  LibFilms_ios_app
//
//  Created by Axel .RP on 05/11/2025.
//

import Foundation
// SUPPRIMER : import AVKit

@Observable
class MovieDetailViewModel {
    
    let movie: MovieModel
    
    // SUPPRIMER : let player: AVPlayer?
    
    // NOUVELLE PROPRIÉTÉ : Extrait l'ID de la vidéo de l'URL
    var videoID: String? {
        guard let urlString = movie.trailerURL,
              let url = URL(string: urlString) else {
            return nil
        }
        
        // Tente d'extraire l'ID d'une URL "watch?v=..."
        if let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
           let queryItem = components.queryItems?.first(where: { $0.name == "v" }) {
            return queryItem.value
        }
        
        // Tente d'extraire l'ID d'une URL "youtu.be/..."
        if url.host?.contains("youtu.be") == true {
            return url.lastPathComponent
        }
        
        // Si aucun format n'est reconnu
        return nil
    }

    var navigationTitle: String {
        movie.title
    }
    
    var directorAndYear: String {
        "De \(movie.director) - \(movie.releaseYear)"
    }
    
    var description: String {
        movie.description
    }
    
    // L'init redevient simple
    init(movie: MovieModel) {
        self.movie = movie
        // SUPPRIMER : Toute la logique de création du player
    }
}
