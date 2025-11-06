//
//  PrimaryButtonView.swift
//  DesignSystem
//
//  Created by Axel .RP on 05/11/2025.
//

import SwiftUI

// La vue doit aussi être 'public'
public struct PrimaryButtonView: View {
    
    let viewModel: PrimaryButtonViewModel
    
    public init(viewModel: PrimaryButtonViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        Button(action: viewModel.action) {
            Text(viewModel.title)
                .font(.headline)
                .frame(maxWidth: .infinity) // Prend toute la largeur
                .padding()
                .background(.thinMaterial)     // Style
                .foregroundColor(.white)    // Style
                .cornerRadius(10)           // Style
        }
    }
}
