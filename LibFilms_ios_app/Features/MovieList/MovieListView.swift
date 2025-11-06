//
//  MovieListView.swift
//  LibFilms_ios_app
//
//  Created by Axel .RP on 05/11/2025.
//

import SwiftUI
import DesignSystem

struct MovieListView: View {
    
    @State var viewModel: MovieListViewModel
    @State private var isShowingAddSheet = false
    
    // Le 'searchText' @State local est maintenant supprimé
    // Nous utilisons 'viewModel.searchText' directement
    
    var body: some View {
        NavigationStack {
            
            // AJOUT : Sélecteur pour filtrer "Tous" ou "Favoris"
            Picker("Filtre", selection: $viewModel.filterStatus) {
                Text("Tous").tag(MovieListViewModel.FilterStatus.all)
                Text("Favoris").tag(MovieListViewModel.FilterStatus.favorites)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            .padding(.top, 8) // Un peu d'espace en haut
            
            // La 'List' contient maintenant un 'ForEach'
            // pour permettre la suppression
            List {
                ForEach(viewModel.filteredMovies) { movie in
                    NavigationLink(value: movie) {
                        // On crée le ViewModel de la carte ici
                        let cardVM = MovieCardViewModel(
                            title: movie.title,
                            details: "\(movie.director) (\(movie.releaseYear))"
                        )
                        MovieCardView(viewModel: cardVM)
                            // AJOUT : Balayage vers la droite pour les favoris
                            .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                Button {
                                    viewModel.toggleFavorite(movie: movie)
                                } label: {
                                    Label("Favori", systemImage: movie.isFavorite ? "star.slash.fill" : "star.fill")
                                }
                                .tint(.yellow)
                            }
                    }
                    .listRowBackground(Color.clear)
                }
                // AJOUT : Balayage vers la gauche pour supprimer
                .onDelete(perform: { offsets in
                    viewModel.deleteMovie(at: offsets)
                })
            }
            .listStyle(.plain)
            .navigationTitle("Ma Bibliothèque")
            .navigationDestination(for: MovieModel.self) { movie in
                let detailVM = MovieDetailViewModel(movie: movie)
                MovieDetailView(viewModel: detailVM)
            }
            .task {
                await viewModel.loadMovies()
                viewModel.filterMovies() // Filtre au premier chargement
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image("AppLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                }
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isShowingAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddSheet) {
                AddMovieView(onSave: { newMovie in
                    Task {
                        await viewModel.addNewMovie(newMovie)
                        viewModel.searchText = "" // Efface la recherche
                        viewModel.filterMovies()
                    }
                })
            }
        }
        .background(
            LinearGradient(
                colors: [Color.black, Color.indigo.opacity(0.3)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
        // MODIFICATION : Lié au @State du ViewModel
        .searchable(text: $viewModel.searchText, prompt: "Rechercher un film ou un réalisateur")
        .onChange(of: viewModel.searchText) {
            Task { @MainActor in
                viewModel.filterMovies()
            }
        }
        // AJOUT : Réagit au changement du sélecteur
        .onChange(of: viewModel.filterStatus) {
            Task { @MainActor in
                viewModel.filterMovies()
            }
        }
        .preferredColorScheme(.dark)
    }
}
