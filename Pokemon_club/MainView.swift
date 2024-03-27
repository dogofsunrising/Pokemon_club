//
//  ContentView.swift
//  Pokemon_club
//
//  Created by 藤本皇汰 on 2024/03/26.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = PokemonViewModel()
    var body: some View {
        NavigationView {
            List(viewModel.pokemons) { pokemon in
                NavigationLink(destination: PokemonDetailView(pokemon: pokemon,allpokemon:viewModel.pokemons)) {
                    Text(pokemon.name)
                }
            }
            .navigationBarTitle("Pokemons")
        }
        .onAppear {
            self.viewModel.fetchPokemonList()
        }
    }
}

struct PokemonDetailView: View {
    let pokemon: Pokemon
    let allpokemon:[Pokemon]
    var body: some View {
        NavigationView{
            Text("Details of \(pokemon.name) id:\(pokemon.id)")
                .navigationBarTitle(pokemon.name)
        }.onAppear {
            print(allpokemon.count)
            print(allpokemon)
        }
    }
}

