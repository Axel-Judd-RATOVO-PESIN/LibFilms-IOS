//
//  AddMovieView.swift
//  LibFilms_ios_app
//
//  Created by Axel .RP on 05/11/2025.
//

import SwiftUI
import DesignSystem

struct AddMovieView: View {
    
    // 1. Les états pour les champs de texte
    @State private var title: String = ""
    @State private var director: String = ""
    @State private var year: String = ""
    @State private var description: String = ""
    @State private var trailerURL: String = "" // <-- AJOUT

    // 2. Une closure (fonction) pour renvoyer le film créé
    var onSave: (MovieModel) -> Void
    
    // 3. Pour fermer la vue (sheet)
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Fond
                LinearGradient(
                    colors: [Color.black, Color.indigo.opacity(0.3)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView { // Ajout d'un ScrollView au cas où le clavier cache les champs
                    VStack(spacing: 15) {
                        // 4. Utilisation de notre nouveau composant
                        GlassTextField(placeholder: "Titre du film", text: $title)
                        GlassTextField(placeholder: "Réalisateur", text: $director)
                        GlassTextField(placeholder: "Année (ex: 2024)", text: $year)
                            .keyboardType(.numberPad) // Clavier numérique pour l'année
                        
                        GlassTextField(placeholder: "Description", text: $description)
                        
                        GlassTextField(placeholder: "Lien bande-annonce (Optionnel)", text: $trailerURL) // <-- AJOUT
                            .keyboardType(.URL)
                            .autocapitalization(.none)

                        Spacer()
                        
                        // 5. Bouton de sauvegarde
                        let saveButtonVM = PrimaryButtonViewModel(
                            title: "Enregistrer",
                            action: {
                                saveMovie()
                            }
                        )
                        PrimaryButtonView(viewModel: saveButtonVM)
                    }
                    .padding()
                }
                .navigationTitle("Nouveau Film")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Annuler") { dismiss() }
                    }
                }
            }
            .preferredColorScheme(.dark)
        }
    }
    
    // --- MODIFICATION DE saveMovie() ---
    private func saveMovie() {
        // Validation simple (titre et réalisateur obligatoires)
        guard !title.isEmpty, !director.isEmpty else { return }
        
        // On gère le lien optionnel
        let finalTrailerURL = trailerURL.isEmpty ? nil : trailerURL
        
        let newMovie = MovieModel(
            id: UUID(),
            title: title,
            director: director,
            releaseYear: Int(year) ?? 2024,
            description: description,
            trailerURL: finalTrailerURL,
            isFavorite: false
        )
        
        // 6. On appelle la closure
        onSave(newMovie)
        
        // 7. On ferme la vue
        dismiss()
    }
}
