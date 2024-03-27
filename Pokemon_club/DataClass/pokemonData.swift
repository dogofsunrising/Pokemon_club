//
//  pokemon.swift
//  Pokemon_club
//
//  Created by 藤本皇汰 on 2024/03/26.
//

import Foundation

struct PokemonListResponse: Codable {
    let results: [PokemonName]
}
struct PokemonName: Codable{
    let name: String
    let url:String
}



struct AllPokemonName: Codable, Identifiable {
    let id: Int
    let name: String
    let url:String
}



struct Pokemon: Codable, Identifiable {
    let abilities: [Ability]//特製
    let height: Int?
    let id: Int
    let moves: [Move]//わざ
    let name: String
    let species: Specie//名前
    let sprites: Sprite//画像
    let types: [Typea]//タイプ
    let weight: Int?
}
struct Ability: Codable {
    let ability: AbilityURL
}
struct AbilityURL: Codable {
    let name: String
    let url: String
}
struct Move: Codable {
    let move: MoveURL
}
struct MoveURL: Codable {
    let name: String
    let url: String
}
struct Specie: Codable {
    let name: String
    let url: String
}
struct Sprite: Codable {
    let frontDefault: String?
    
}
struct Typea: Codable {
    let type: TypeURL
}
struct TypeURL: Codable {
    let name: String
    let url: String
}




struct Speciedetail:Codable{
    let evolves_from_species:evolves?
    let flavor_text_entries:[flavor]
    let genera:[genera]
    let names:[names]
}
struct evolves:Codable{
    let name:String
    let url:String
}
struct flavor:Codable{
    let flavor_text:String
    let language:language
}
struct language:Codable{
    let name:String
}
struct genera:Codable{
    let genus:String
    let language:language
}
struct names:Codable{
    let language:language
    let name:String
}



struct AbilityDetail:Codable{
    let flavor_text_entries:[flavor]
    let names:[names]
}


struct MoveDetail:Codable{
    let damage_class:damagetype
    let flavor_text_entries:[flavor]
    let names:[names]
}
struct damagetype:Codable{
    let name:String
}


struct TypeDetail:Codable{
    let damage_relations:typerelation
    let names:[names]
}
struct typerelation:Codable{
    let double_damage_from:[URLa]
    let double_damage_to:[URLa]
    let half_damage_from:[URLa]
    let half_damage_to:[URLa]
    let no_damage_from:[URLa]
    let no_damage_to:[URLa]
}
struct URLa:Codable{
    let name:String
    let url:String
}


struct ThePokemon:Codable,Identifiable{
    let abilities: [AbilityDetail]//特製
    let height: Int?
    let id: Int
    let moves: [MoveDetail]//わざ
    let name: String
    let species: Speciedetail//名前
    let sprites: Sprite//画像
    let types: [TypeDetail]//タイプ
    let weight: Int?
}
