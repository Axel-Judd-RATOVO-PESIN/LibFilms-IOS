//
//  MockMovieService.swift
//  LibFilms_ios_app
//
//  Created by Axel .RP on 05/11/2025.
//

import Foundation

class MockMovieService: MovieServiceProtocol {
    
    // La liste "master" de nos données.
    // Elle est 'var' pour qu'on puisse la modifier (ajouter/supprimer)
    private var mockData: [MovieModel] = [
            .init(id: UUID(), title: "Dune (Part II)", director: "D. Villeneuve", releaseYear: 2024, description: "Paul Atreides s'unit à Chani et aux Fremen pour mener la révolte contre les Harkonnen. Il est confronté au choix entre l'amour de sa vie et le destin de l'univers.", trailerURL: "https://www.youtube.com/watch?v=A-bdisH-pLw", isFavorite: false),
            .init(id: UUID(), title: "Inception", director: "C. Nolan", releaseYear: 2010, description: "Un voleur expérimenté, Dom Cobb, est le meilleur dans l'art dangereux de l'extraction : il vole des secrets précieux au plus profond du subconscient pendant le rêve.", trailerURL: "https://www.youtube.com/watch?v=HiM1z1A1k-w", isFavorite: false),
            .init(id: UUID(), title: "Interstellar", director: "C. Nolan", releaseYear: 2014, description: "Alors que la Terre se meurt, un ancien pilote de la NASA, Cooper, doit voyager à travers un trou de ver à la recherche d'une nouvelle planète habitable pour sauver l'humanité.", trailerURL: "https://www.youtube.com/watch?v=Ee-f-2y1lG8", isFavorite: false),
            .init(id: UUID(), title: "The Matrix", director: "Wachowskis", releaseYear: 1999, description: "Un pirate informatique, Neo, découvre que le monde qu'il connaît n'est qu'une simulation virtuelle (la Matrice) et rejoint une rébellion pour libérer l'humanité.", trailerURL: "https://www.youtube.com/watch?v=vKQi3bBA1y8", isFavorite: false),
            .init(id: UUID(), title: "Oppenheimer", director: "C. Nolan", releaseYear: 2023, description: "Le portrait du physicien J. Robert Oppenheimer, directeur du projet Manhattan, qui a conduit au développement de la première bombe atomique.", trailerURL: "https://www.youtube.com/watch?v=g0_N-vTRc-o", isFavorite: false),
            .init(id: UUID(), title: "Blade Runner 2049", director: "D. Villeneuve", releaseYear: 2017, description: "L'officier K, un nouveau Blade Runner, découvre un secret enfoui depuis longtemps qui pourrait plonger ce qui reste de la société dans le chaos et le mène à la recherche de Rick Deckard.", trailerURL: "https://www.youtube.com/watch?v=dZOaI_Fn5o4", isFavorite: false),
            .init(id: UUID(), title: "Pulp Fiction", director: "Q. Tarantino", releaseYear: 1994, description: "Les destins de deux tueurs à gages, d'un boxeur, de la femme d'un gangster et d'un couple de braqueurs s'entremêlent dans une série d'histoires violentes et comiques.", trailerURL: "https://www.youtube.com/watch?v=s7EdQ4FqbhY", isFavorite: false),
            .init(id: UUID(), title: "The Godfather", director: "F. F. Coppola", releaseYear: 1972, description: "Le patriarche vieillissant d'une dynastie du crime organisé transfère le contrôle de son empire clandestin à son fils réticent, Michael Corleone.", trailerURL: "https://www.youtube.com/watch?v=UaVTIH8h-qY", isFavorite: false),
            .init(id: UUID(), title: "The Dark Knight", director: "C. Nolan", releaseYear: 2008, description: "Batman, le lieutenant Gordon et le procureur Harvey Dent forment une alliance pour démanteler le crime organisé à Gotham, mais ils se heurtent à un nouveau génie criminel, le Joker.", trailerURL: "https://www.youtube.com/watch?v=EXeTwQWrcwY", isFavorite: false),
            .init(id: UUID(), title: "Parasite", director: "Bong Joon-ho", releaseYear: 2019, description: "La famille Ki-taek, sans emploi, s'infiltre peu à peu dans la vie de la riche famille Park, mais un incident inattendu fait basculer leur plan dans le chaos.", trailerURL: "https://www.youtube.com/watch?v=SEUXfv87Wpk", isFavorite: false),
            .init(id: UUID(), title: "Gladiator", director: "R. Scott", releaseYear: 2000, description: "Un général romain, Maximus, est trahi et sa famille assassinée par l'empereur Commode. Il devient esclave, puis gladiateur, cherchant à venger sa famille.", trailerURL: "https://www.youtube.com/watch?v=owK1qxDselE", isFavorite: false),
            .init(id: UUID(), title: "Fight Club", director: "D. Fincher", releaseYear: 1999, description: "Un employé de bureau insomniaque, mécontent de sa vie, forme un club de combat clandestin avec un fabricant de savon charismatique, Tyler Durden.", trailerURL: "https://www.youtube.com/watch?v=BdJKm16Co6M", isFavorite: false),
            .init(id: UUID(), title: "Forrest Gump", director: "R. Zemeckis", releaseYear: 1994, description: "L'histoire des États-Unis de 1950 à 1970 vue à travers les yeux d'un homme simple d'esprit, Forrest Gump, qui se retrouve par hasard au cœur d'événements majeurs.", trailerURL: "https://www.youtube.com/watch?v=tvKjS2s1v0k", isFavorite: false),
            .init(id: UUID(), title: "Se7en", director: "D. Fincher", releaseYear: 1995, description: "Deux détectives, un vétéran et un novice, traquent un tueur en série qui utilise les sept péchés capitaux comme modus operandi pour ses meurtres.", trailerURL: "https://www.youtube.com/watch?v=znmZoVkCjpI", isFavorite: false),
            .init(id: UUID(), title: "Arrival", director: "D. Villeneuve", releaseYear: 2016, description: "Lorsuqe de mystérieux vaisseaux extraterrestres arrivent sur Terre, une linguiste, Dr Louise Banks, est recrutée pour tenter de communiquer avec eux.", trailerURL: "https://www.youtube.com/watch?v=tFMo3UJCFx4", isFavorite: false),
            .init(id: UUID(), title: "The Shawshank Redemption", director: "F. Darabont", releaseYear: 1994, description: "Un banquier, Andy Dufresne, est condamné à tort pour meurtre et purge sa peine à la prison de Shawshank, où il trouve l'espoir et la rédemption grâce à sa volonté.", trailerURL: "https://www.youtube.com/watch?v=scs-QAlK15Y", isFavorite: false),
            .init(id: UUID(), title: "Mad Max: Fury Road", director: "G. Miller", releaseYear: 2015, description: "Dans un désert post-apocalyptique, Max s'associe à l'impératrice Furiosa, qui fuit le tyran Immortan Joe avec ses épouses, dans une course-poursuite effrénée.", trailerURL: "https://www.youtube.com/watch?v=hEJnMQG9ev8", isFavorite: false),
            .init(id: UUID(), title: "Spider-Man: Into the Spider-Verse", director: "Collectif", releaseYear: 2018, description: "Miles Morales, un adolescent de Brooklyn, est mordu par une araignée radioactive et découvre un multivers (le 'Spider-Verse') où plusieurs Spider-Man existent.", trailerURL: "https://www.youtube.com/watch?v=tg52up16eq0", isFavorite: false),
            .init(id: UUID(), title: "Whiplash", director: "D. Chazelle", releaseYear: 2014, description: "Andrew Neiman, un jeune batteur de jazz ambitieux, est poussé à ses limites par un professeur de musique impitoyable et tyrannique, Terence Fletcher.", trailerURL: "https://www.youtube.com/watch?v=7d_jQycdQGo", isFavorite: false),
            .init(id: UUID(), title: "Get Out", director: "J. Peele", releaseYear: 2017, description: "Un jeune photographe afro-américain, Chris, visite la famille de sa petite amie blanche pour le week-end, mais découvre rapidement un secret racial et terrifiant.", trailerURL: "https://www.youtube.com/watch?v=DzfpyUB60YY", isFavorite: false)
        ]
    
    // --- Implémentation des fonctions du protocole ---
    
    func fetchMovies() async throws -> [MovieModel] {
        try await Task.sleep(nanoseconds: 1_000_000_000) // Simule 1s de réseau
        return mockData
    }
    
    func fetchMovie(id: UUID) async throws -> MovieModel {
        try await Task.sleep(nanoseconds: 500_000_000) // Simule 0.5s
        guard let movie = mockData.first(where: { $0.id == id }) else {
            throw NSError(domain: "MockError", code: 404)
        }
        return movie
    }
    
    func addMovie(_ movie: MovieModel) async throws {
        try await Task.sleep(nanoseconds: 300_000_000) // Simule 0.3s
        // Ajoute le nouveau film au début de la liste
        mockData.insert(movie, at: 0)
    }
    
    func deleteMovie(id: UUID) async throws {
        try await Task.sleep(nanoseconds: 200_000_000) // Simule 0.2s
        // Supprime le film de la liste "master"
        mockData.removeAll { $0.id == id }
    }
    
    func toggleFavorite(id: UUID) async throws {
        try await Task.sleep(nanoseconds: 100_000_000) // Simule 0.1s
        
        // Trouve l'index du film dans la liste "master"
        if let index = mockData.firstIndex(where: { $0.id == id }) {
            // Inverse le booléen
            mockData[index].isFavorite.toggle()
        }
    }
}
