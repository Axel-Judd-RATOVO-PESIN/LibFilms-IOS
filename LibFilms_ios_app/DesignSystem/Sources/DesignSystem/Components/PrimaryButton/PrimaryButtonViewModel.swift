//
//  PrimaryButtonViewModel.swift
//  DesignSystem
//
//  Created by Axel .RP on 05/11/2025.
//

public struct PrimaryButtonViewModel {
    public let title: String
    
    public let action: () -> Void // L'action à exécuter
        
    // Le 'init' doit aussi être 'public'
    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
}
