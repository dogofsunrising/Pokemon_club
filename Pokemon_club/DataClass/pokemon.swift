//
//  pokemon.swift
//  Pokemon_club
//
//  Created by 藤本皇汰 on 2024/03/26.
//

import Foundation

struct PokemonListResponse: Codable {
    let results: [PokemonAPI]
}

struct Pokemon: Codable, Identifiable {
    let id: Int
    let name: String
    let url:String
}

struct PokemonAPI: Codable{
    let name: String
    let url:String
}
