//
//  PokemoninfoAPI.swift
//  Pokemon_club
//
//  Created by 藤本皇汰 on 2024/03/27.
//
import Foundation

import SwiftUI

class InfoViewModel: ObservableObject {
    @Published var pokemons: [AllPokemonName] = []
    
    func fetchPokemonList() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=1") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                do {
                    let pokemonListResponse = try JSONDecoder().decode(PokemonListResponse.self, from: data)
                    
                    var pokemons: [AllPokemonName] = []
                    for result in pokemonListResponse.results {
                        // ポケモンのURLからIDを取得
                        if let idString = result.url.split(separator: "/").last,
                           let id = Int(idString) {
                            let pokemon = AllPokemonName(id: id, name: result.name,url: result.url)
                            pokemons.append(pokemon)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.pokemons = pokemons
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}
