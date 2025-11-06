//
//  MainTabView.swift
//  LibFilms_ios_app
//
//  Created by Axel .RP on 05/11/2025.
//

import SwiftUI

struct MainTabView: View {
    
    // 1. On récupère le service pour le passer à la liste
    let movieService: MovieServiceProtocol
    
    // 2. On récupère le Binding pour pouvoir se déconnecter
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        TabView {
            // -- ONGLET 1 : BIBLIOTHÈQUE --
            // On injecte le ViewModel comme on le faisait dans App.swift
            let movieListVM = MovieListViewModel(movieService: movieService)
            MovieListView(viewModel: movieListVM)
                .tabItem {
                    Label("Bibliothèque", systemImage: "film.stack")
                }
            
            // -- ONGLET 2 : PROFIL --
            // C'est notre nouvelle vue (Phase 3)
            ProfileView(isLoggedIn: $isLoggedIn)
                .tabItem {
                    Label("Profil", systemImage: "person.fill")
                }
        }
        // Pour que le style "verre" de la TabView s'adapte à notre fond sombre
        .preferredColorScheme(.dark)
    }
}
