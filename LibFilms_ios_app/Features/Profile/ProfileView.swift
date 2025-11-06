//
//  ProfileView.swift
//  LibFilms_ios_app
//
//  Created by Axel .RP on 05/11/2025.
//

import SwiftUI
import DesignSystem
import PhotosUI

struct ProfileView: View {
    
    // --- ÉTATS EXISTANTS ---
    @Binding var isLoggedIn: Bool
    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var profileImage: Image?
    
    // Clé de stockage pour l'image
    private let photoStorageKey = "profileImageData"
    
    // --- AMÉLIORATION 1 : ÉTAT POUR LE NOM ---
    // @AppStorage est un wrapper magique pour UserDefaults.
    // Il sauvegarde et charge automatiquement le nom.
    @AppStorage("username") private var username: String = ""
    
    // --- AMÉLIORATION 3 : ÉTAT POUR L'ALERTE ---
    @State private var isShowingLogoutConfirm = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Fond sombre
                LinearGradient(
                    colors: [Color.black, Color.indigo.opacity(0.3)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                // --- AMÉLIORATION 2 : FLUIDITÉ (ScrollView) ---
                // Garantit que la vue peut défiler sur les petits écrans
                ScrollView {
                    VStack(spacing: 20) {
                        
                        // --- AMÉLIORATION 2 : LA "CARTE PROFIL" ---
                        // On regroupe la photo et le nom dans une seule
                        // carte "en verre" pour une meilleure logique.
                        VStack(spacing: 15) {
                            
                            // Le sélecteur de photos
                            PhotosPicker(
                                selection: $selectedPhotoItem,
                                matching: .images,
                                photoLibrary: .shared()
                            ) {
                                // Le bouton est maintenant l'image elle-même
                                if let profileImage {
                                    profileImage
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 150, height: 150)
                                        .clipShape(Circle())
                                } else {
                                    // Placeholder "en verre"
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 80))
                                        .foregroundColor(.white.opacity(0.7))
                                        .frame(width: 150, height: 150) // Cadre fixe
                                        .background(.thinMaterial)
                                        .clipShape(Circle())
                                }
                            }
                            .buttonStyle(.plain) // Enlève tout style de bouton
                            
                            Text("Modifier la photo")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            // --- AMÉLIORATION 1 : CHAMP DE NOM ---
                            // On réutilise notre composant DesignSystem !
                            GlassTextField(
                                placeholder: "Entrez votre nom",
                                text: $username
                            )
                        }
                        .padding(25) // Plus de padding intérieur
                        .background(.ultraThinMaterial) // Effet "verre"
                        .cornerRadius(20)
                        .padding(.horizontal) // Marge gauche/droite
                        .padding(.top, 30) // Espace avec la barre de navigation
                        
                        
                        Spacer(minLength: 50) // Espace minimum
                        
                        // --- BOUTON DE DÉCONNEXION (inchangé) ---
                        // Il est maintenant poussé en bas
                        PrimaryButtonView(viewModel: .init(
                            title: "Se déconnecter",
                            action: {
                                // --- AMÉLIORATION 3 : AFFICHER L'ALERTE ---
                                isShowingLogoutConfirm = true
                            }
                        ))
                        .padding(.horizontal)
                        .padding(.bottom) // Espace avec la TabView
                        
                    }
                }
                .navigationTitle("Mon Profil")
            }
        }
        .preferredColorScheme(.dark)
        // --- GESTION DE L'IMAGE (inchangée) ---
        .onChange(of: selectedPhotoItem) {
            Task {
                if let data = try? await selectedPhotoItem?.loadTransferable(type: Data.self) {
                    // Sauvegarder dans UserDefaults
                    UserDefaults.standard.set(data, forKey: photoStorageKey)
                    if let uiImage = UIImage(data: data) {
                        await MainActor.run {
                            self.profileImage = Image(uiImage: uiImage)
                        }
                    }
                }
            }
        }
        // --- CHARGEMENT DE L'IMAGE (inchangé) ---
        .onAppear {
            if let data = UserDefaults.standard.data(forKey: photoStorageKey) {
                if let uiImage = UIImage(data: data) {
                    self.profileImage = Image(uiImage: uiImage)
                }
            }
        }
        // --- AMÉLIORATION 3 : L'ALERTE DE CONFIRMATION ---
        .alert("Se déconnecter", isPresented: $isShowingLogoutConfirm) {
            Button("Annuler", role: .cancel) { }
            Button("Confirmer", role: .destructive) {
                // Action de déconnexion
                UserDefaults.standard.removeObject(forKey: photoStorageKey)
                username = "" // On efface aussi le nom
                isLoggedIn = false
            }
        } message: {
            Text("Êtes-vous sûr de vouloir vous déconnecter ?")
        }
    }
}
