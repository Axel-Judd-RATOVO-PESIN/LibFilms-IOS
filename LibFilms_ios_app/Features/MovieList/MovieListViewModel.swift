//
//  MovieListViewModel.swift
//  LibFilms_ios_app
//
//  Created by Axel .RP on 05/11/2025.
//

import Foundation

@Observable
class MovieListViewModel {
    
    // 1. Les États de la Vue
    
    /// La liste "master" complète, chargée depuis le service.
    var movies: [MovieModel] = []
    
    /// La liste qui est réellement affichée à l'écran, après filtrage.
    var filteredMovies: [MovieModel] = []
    
    /// Le texte tapé dans la barre de recherche (lié au @State de la View).
    var searchText: String = ""
    
    /// Le statut du sélecteur "Tous" / "Favoris".
    var filterStatus: FilterStatus = .all
    
    /// L'enum pour le sélecteur.
    enum FilterStatus {
        case all, favorites
    }
    
    // 2. Le Service
    private let movieService: MovieServiceProtocol
    
    // 3. Initialisation
    init(movieService: MovieServiceProtocol) {
        self.movieService = movieService
    }
    
    // 4. Fonctions (Logique Métier)
    
    /// Charge les films depuis le service et les place dans la liste "master".
    @MainActor
    func loadMovies() async {
        do {
            self.movies = try await movieService.fetchMovies()
        } catch {
            print("Erreur de chargement: \(error)")
        }
    }
    
    /// Appelé par le bouton "+"
    @MainActor
    func addNewMovie(_ movie: MovieModel) async {
        do {
            try await movieService.addMovie(movie)
            // Après l'ajout, on recharge tout pour être à jour
            await loadMovies()
            filterMovies()
        } catch {
            print("Erreur lors de l'ajout: \(error)")
        }
    }

    /// Appelé par le geste de suppression `.onDelete`
    @MainActor
    func deleteMovie(at offsets: IndexSet) {
        // 1. Trouver quels films l'utilisateur a balayé (dans la liste filtrée)
        let moviesToDelete = offsets.map { filteredMovies[$0] }
        
        Task {
            // 2. Supprimer chaque film via le service
            for movie in moviesToDelete {
                do {
                    try await movieService.deleteMovie(id: movie.id)
                } catch {
                    print("Erreur lors de la suppression: \(error)")
                }
            }
            
            // 3. Recharger les données et ré-appliquer les filtres
            await loadMovies()
            filterMovies()
        }
    }
    
    /// Appelé par le geste de balayage "Favori"
    @MainActor
    func toggleFavorite(movie: MovieModel) {
        Task {
            do {
                // 1. Appelle le service pour mettre à jour le "backend"
                try await movieService.toggleFavorite(id: movie.id)
                
                // 2. Met à jour la liste "master" locale instantanément
                // (pour que la UI soit réactive)
                if let index = movies.firstIndex(where: { $0.id == movie.id }) {
                    movies[index].isFavorite.toggle()
                }
                
                // 3. Ré-applique les filtres pour mettre à jour la liste affichée
                filterMovies()
                
            } catch {
                print("Erreur lors du changement de favori: \(error)")
            }
        }
    }
    
    /// La fonction la plus importante :
    /// Met à jour `filteredMovies` en fonction de `filterStatus` ET `searchText`.
    @MainActor
    func filterMovies() {
        
        var tempMovies = movies
        
        // 1. D'abord, on filtre par statut (Tous / Favoris)
        if filterStatus == .favorites {
            tempMovies = tempMovies.filter { $0.isFavorite }
        }
        
        // 2. Ensuite, on filtre par recherche (sur la liste déjà filtrée)
        if searchText.isEmpty {
            // Si la recherche est vide, on montre tous les films (du filtre 1)
            filteredMovies = tempMovies
        } else {
            let lowercasedQuery = searchText.lowercased()
            filteredMovies = tempMovies.filter { movie in
                movie.title.lowercased().contains(lowercasedQuery) ||
                movie.director.lowercased().contains(lowercasedQuery)
            }
        }
    }
}
