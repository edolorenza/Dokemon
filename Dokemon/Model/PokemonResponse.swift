//
//  PokemonResponse.swift
//  Dokemon
//
//  Created by Edo Lorenza on 20/06/21.
//

import Foundation

// MARK: - WelcomeClass
struct PokemonResponse: Codable {
    let attack: Int
    let defense: Int
    let description: String
    let evolutionChain: [EvolutionChain]?
    let height: Int
    let id: Int
    let imageUrl: String
    let name: String
    let type: String
    let weight: Int
}

// MARK: - EvolutionChain
struct EvolutionChain: Codable {
    let id: String
    let name: String
}

typealias pokemon = [PokemonResponse?]

