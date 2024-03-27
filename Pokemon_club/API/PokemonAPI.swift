//
//  API.swift
//  Pokemon_club
//
//  Created by 藤本皇汰 on 2024/03/26.
//

import Foundation

import SwiftUI

class PokemonViewModel: ObservableObject {
    
    @Published var pokemons: [AllPokemonName] = []
    @Published var Theperfectpokemons:[ThePokemon] = []
    @Published var perfectpokemons:[Pokemon] = []
    var preperfectpokemons:[Pokemon] = []
    var ThePokemons:[ThePokemon] = []
    let dispatchGroup = DispatchGroup()
    
    func fetchPokemonList() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=1025") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                do {
                    let pokemonListResponse = try JSONDecoder().decode(PokemonListResponse.self, from: data)
                    
                    var pokemons: [AllPokemonName] = []
                    var fetchCount = 0 // 取得したポケモンの数をカウントする変数を追加
                    
                    for result in pokemonListResponse.results {
                        if let idString = result.url.split(separator: "/").last,
                           let id = Int(idString) {
                            let pokemon = AllPokemonName(id: id, name: result.name, url: result.url)
                            pokemons.append(pokemon)
                            
                            self.fetchPokemonInfo(I_F: pokemon) {
                                fetchCount += 1 // ポケモン情報の取得が完了したらカウントを増やす
                                if fetchCount == pokemonListResponse.results.count {
                                    // 全てのポケモン情報を取得した後に次の処理を実行する
                                    self.lastFunction()
                                }
                            }
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

    func fetchPokemonInfo(I_F: AllPokemonName, completion: @escaping () -> Void) {
        let pokemonurl = I_F.url
        guard let url = URL(string: pokemonurl) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                do {
                    let pokemonListResponse = try JSONDecoder().decode(Pokemon.self, from: data)
                    self.preperfectpokemons.append(pokemonListResponse)
                    DispatchQueue.main.async {
                        completion() // 非同期処理が完了したことを通知する
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
    func lastFunction() {
        self.perfectpokemons = self.preperfectpokemons.sorted { $0.id < $1.id }
    }
    
    
    func PokemonSpeciesFunction(url_s: String, completion: @escaping (Speciedetail) -> Void) {
        guard let url = URL(string: url_s) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                do {
                    let pokemonListResponse = try JSONDecoder().decode(Speciedetail.self, from: data)
                    DispatchQueue.main.async {
                        completion(pokemonListResponse)
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                    
                }
            }
        }.resume()
    }
    
    func PokemonAbilityFunction(ability: [Ability], completion: @escaping ([AbilityDetail]) -> Void) {
        var abilities:[AbilityDetail] = []
        for it in ability {
            guard let url = URL(string: it.ability.url) else {
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    do {
                        let pokemonListResponse = try JSONDecoder().decode(AbilityDetail.self, from: data)
                        DispatchQueue.main.async {
                            abilities.append(pokemonListResponse)
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                        
                    }
                }
            }.resume()
        }
        DispatchQueue.main.async {
            completion(abilities)
        }

    }
    
    func PokemonMoveFunction(move: [Move], completion: @escaping ([MoveDetail]) -> Void) {
        var movis:[MoveDetail] = []
        for it in move {
            guard let url = URL(string: it.move.url) else {
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    do {
                        let pokemonListResponse = try JSONDecoder().decode(MoveDetail.self, from: data)
                        DispatchQueue.main.async {
                            movis.append(pokemonListResponse)
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                        
                    }
                }
            }.resume()
        }
        DispatchQueue.main.async {
            completion(movis)
        }

    }
    
    func PokemonTypeFunction(type: [Typea], completion: @escaping ([TypeDetail]) -> Void) {
        var types:[TypeDetail] = []
        for it in type {
            guard let url = URL(string: it.type.url) else {
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    do {
                        let pokemonListResponse = try JSONDecoder().decode(TypeDetail.self, from: data)
                        DispatchQueue.main.async {
                            types.append(pokemonListResponse)
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                        
                    }
                }
            }.resume()
        }
        DispatchQueue.main.async {
            completion(types)
        }

    }
    
    
    
    
    
    
    
    
    
    func OneSpecieFunction(url_s: String, completion: @escaping (Speciedetail) -> Void) {
        guard let url = URL(string: url_s) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                do {
                    let pokemonListResponse = try JSONDecoder().decode(Speciedetail.self, from: data)
                    DispatchQueue.main.async {
                        completion(pokemonListResponse)
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                    
                }
            }
        }.resume()
    }
    
    func OneAbilityFunction(ability: Ability, completion: @escaping (AbilityDetail) -> Void) {
      
       
        guard let url = URL(string: ability.ability.url) else {
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    do {
                        let pokemonListResponse = try JSONDecoder().decode(AbilityDetail.self, from: data)
                        DispatchQueue.main.async {
                            completion(pokemonListResponse)
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                        
                    }
                }
            }.resume()
        
       

    }
    
    func OneMoveFunction(move: Move, completion: @escaping (MoveDetail) -> Void) {
       
       
            guard let url = URL(string: move.move.url) else {
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    do {
                        let pokemonListResponse = try JSONDecoder().decode(MoveDetail.self, from: data)
                        DispatchQueue.main.async {
                            completion(pokemonListResponse)
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                        
                    }
                }
            }.resume()
        
        

    }
    
    func OneTypeFunction(type: Typea, completion: @escaping (TypeDetail) -> Void) {
       
       
            guard let url = URL(string: type.type.url) else {
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    do {
                        let pokemonListResponse = try JSONDecoder().decode(TypeDetail.self, from: data)
                        DispatchQueue.main.async {
                            completion(pokemonListResponse)
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                        
                    }
                }
            }.resume()
        }
}
