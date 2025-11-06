//
//  YoutubeWebView.swift
//  LibFilms_ios_app
//
//  Created by Axel .RP on 05/11/2025.
//

import SwiftUI
import WebKit

struct YouTubeWebView: UIViewRepresentable {
    
    let videoID: String
    
    func makeUIView(context: Context) -> WKWebView {
        // --- MODIFICATION ---
        // On configure le webview pour autoriser la lecture
        // "inline" (dans la page) et non en plein écran.
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.isOpaque = false // Garde le fond transparent
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // --- MODIFICATION MAJEURE ---
        // Nous n'allons plus charger de HTML.
        
        guard let embedURL = URL(string: "https://www.youtube.com/embed/\(videoID)") else {
            return
        }
        
        // 1. On crée une requête URL
        var request = URLRequest(url: embedURL)
        
        // 2. C'est la ligne magique :
        // On définit le "Referer" pour contourner la restriction (Erreur 153)
        // On fait croire à YouTube que la demande vient de son propre site.
        request.setValue("https://www.youtube.com", forHTTPHeaderField: "Referer")
        
        // 3. On charge la requête directement
        uiView.load(request)
    }
}
