//
//  LibFilms_ios_appApp.swift
//  LibFilms_ios_app
//
//  Created by Axel .RP on 05/11/2025.
//

import SwiftUI

@main
struct LibFilms_ios_appApp: App {
    // 1. On crée notre service "mock" ici
    private let movieService = MockMovieService()

    //2. On ajoute un état pour savoir si l'utilisateur est loggé
    @State private var isLoggedIn = false
    
    var body: some Scene {
        WindowGroup {
            
            if isLoggedIn {
                // MODIFICATION :
                // On ne montre plus MovieListView directement
                MainTabView(movieService: movieService, isLoggedIn: $isLoggedIn)

            } else {
                // L'utilisateur n'est pas connecté, on montre le Login
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}
