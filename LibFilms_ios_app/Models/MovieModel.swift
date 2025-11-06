//
//  MovieModel.swift
//  LibFilms_ios_app
//
//  Created by Axel .RP on 05/11/2025.
//

import Foundation

struct MovieModel: Identifiable, Hashable{
    let id: UUID
    let title: String
    let director: String
    let releaseYear: Int
    let description: String
    let trailerURL: String?
    var isFavorite: Bool
}
