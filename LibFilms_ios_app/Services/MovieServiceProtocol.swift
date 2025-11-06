//
//  MovieServiceProtocol.swift
//  LibFilms_ios_app
//
//  Created by Axel .RP on 05/11/2025.
//

import Foundation

protocol MovieServiceProtocol {
    // Utilise async/await comme demandé 
    func fetchMovies() async throws -> [MovieModel]
    func fetchMovie(id: UUID) async throws -> MovieModel
    func addMovie(_ movie: MovieModel) async throws // <-- AJOUT
    func deleteMovie(id: UUID) async throws
    func toggleFavorite(id: UUID) async throws
    
}
