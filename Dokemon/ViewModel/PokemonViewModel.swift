//
//  PokemonViewModel.swift
//  Dokemon
//
//  Created by Edo Lorenza on 20/06/21.
//

import UIKit

struct PokemonViewModel {
    let pokemon: PokemonResponse
    
    init(pokemon: PokemonResponse) {
        self.pokemon = pokemon
    }
    
    var pokemonImg: URL? {
        return URL(string: pokemon.imageUrl)
    }
    
    var name: String{
        return pokemon.name.capitalizingFirstLetter()
    }
    
    var type: String{
        return pokemon.type
    }
    
    func backgroundColor(forType type: String) -> UIColor {
        switch type {
            case "fire": return .systemRed
            case "poison": return .systemGreen
            case "grass": return .systemGreen
            case "water": return .systemBlue
            case "electric": return .systemYellow
            case "psychic": return .systemPurple
            case "normal": return .systemOrange
            case "fighting": return .gray
            case "ground": return .brown
            case "flying": return .systemTeal
            case "fairy": return .systemPink
            case "dragon": return .systemOrange
            case "bug": return .systemIndigo
            case "ice": return .blue
            case "rock": return .darkGray
            case "steel": return .systemGray2
            default: return .white
        }
    }
    
    var description: String{
        pokemon.description
    }
    
    var height: String {
        return String(pokemon.height)
    }
    
    var attack: String {
        return String(pokemon.attack)
    }
    
    var defense: String{
        return String(pokemon.defense)
    }
    
    var weight: String {
        return String(pokemon.weight)
    }
    
    var heightStats: Float {
        return Float(pokemon.height)
    }
    
    var attackStats: Float {
        return Float(pokemon.attack)
    }
    
    var defenseStats: Float {
        return Float(pokemon.defense)
    }
    
    var weightStats: Float {
        return Float(pokemon.weight)
    }
}

