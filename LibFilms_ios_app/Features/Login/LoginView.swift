//
//  LoginView.swift
//  LibFilms_ios_app
//
//  Created by Axel .RP on 05/11/2025.
//

import SwiftUI
import DesignSystem

struct LoginView: View {
    
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        ZStack {
            // 1. LE FOND SOMBRE (identique à la bibliothèque)
            // C'est la couleur "sobre" que vous vouliez
            LinearGradient(
                colors: [Color.black, Color.indigo.opacity(0.3)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // 2. LA BOÎTE CENTRALE "EN VERRE"
            // Cette VStack est maintenant naturellement centrée
            VStack(spacing: 25) {
                
                // 3. LE LOGO (bien centré et mis en valeur)
                // Il remplace l'icône "person.circle.fill"
                Image("AppLogo") // Assurez-vous que 'AppLogo' est dans vos Assets
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150) // N'hésitez pas à ajuster la taille
                    
                
                Text("Bienvenue")
                    .font(.largeTitle)
                    .fontWeight(.thin)
                    .foregroundColor(.white) // Texte blanc sur fond sombre
                
                // 4. LE BOUTON D'ACCÈS
                let buttonVM = PrimaryButtonViewModel(
                    title: "Accéder à ma bibliothèque",
                    action: {
                        isLoggedIn = true
                    }
                )
                PrimaryButtonView(viewModel: buttonVM)
                
            }
            .padding(40) // Un peu plus de padding
            .background(.ultraThinMaterial) // L'effet "verre"
            .cornerRadius(20)
            .shadow(radius: 10)
            .padding(.horizontal) // Marge sur les côtés
        }
        .preferredColorScheme(.dark) // Assure que les éléments système sont sombres
    }
}
