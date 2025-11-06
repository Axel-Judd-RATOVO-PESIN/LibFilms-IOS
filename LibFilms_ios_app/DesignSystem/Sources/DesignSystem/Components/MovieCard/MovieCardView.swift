//
//  MovieCardView.swift
//  DesignSystem
//
//  Created by Axel .RP on 05/11/2025.
//

import SwiftUI

public struct MovieCardView: View {
    let viewModel: MovieCardViewModel

    public init(viewModel: MovieCardViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.title).font(.headline).foregroundColor(.white)
            Text(viewModel.details).font(.subheadline).foregroundStyle(.white.opacity(0.7))
        }
        .padding(10)
        // MODIFICATION :
        .background(.ultraThinMaterial) // Remplace Color.gray.opacity(0.1)
        .cornerRadius(12) // Un peu plus arrondi
        .overlay( // AJOUT : Une petite bordure blanche pour l'effet "verre"
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
    }
}
