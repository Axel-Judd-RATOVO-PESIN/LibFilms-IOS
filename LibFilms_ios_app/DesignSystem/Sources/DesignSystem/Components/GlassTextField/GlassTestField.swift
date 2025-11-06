//
//  GlassTestField.swift
//  DesignSystem
//
//  Created by Axel .RP on 05/11/2025.
//

import SwiftUI

public struct GlassTextField: View {
    let placeholder: String
    @Binding var text: String // Doit être un Binding

    public init(placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }

    public var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(.thinMaterial)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
    }
}
