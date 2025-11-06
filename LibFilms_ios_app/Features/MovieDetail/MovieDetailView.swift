//
//  MovieDetailView.swift
//  LibFilms_ios_app
//
//  Created by Axel .RP on 05/11/2025.
//
import SwiftUI
import DesignSystem
// SUPPRIMER : import AVKit

struct MovieDetailView: View {
    
    @State var viewModel: MovieDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                
                Text(viewModel.directorAndYear)
                    .font(.headline)
                    .foregroundStyle(.white.opacity(0.9))

                Text(viewModel.description)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.8))
                
                // --- MODIFICATION ICI ---
                // On vérifie si le ViewModel a pu extraire un ID
                if let videoID = viewModel.videoID {
                    
                    Text("Bande-annonce")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top)

                    // On utilise notre nouveau composant WebView
                    YouTubeWebView(videoID: videoID)
                        .frame(height: 220)
                        .cornerRadius(12)
                    
                } else {
                    Text("Bande-annonce non disponible")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding(.top)
                }
            }
            .padding()
        }
        .navigationTitle(viewModel.navigationTitle)
        .preferredColorScheme(.dark)
        
        // SUPPRIMER : .onDisappear
    }
}
