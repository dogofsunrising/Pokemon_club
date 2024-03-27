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
            if(viewModel.perfectpokemons.isEmpty){
                ProgressView()
            }else{
                List(viewModel.perfectpokemons) { pokemon in
                    NavigationLink(destination: PokemonDetailView(id: pokemon.id)) {
                        PokemonListView(pokemon: pokemon)
                    }
                }
                .navigationBarTitle("Pokemons")
            }
        }
        .onAppear {
            self.viewModel.fetchPokemonList()
        }
    }
}

struct PokemonDetailView: View {
    var viewModel = PokemonViewModel()
    let id:Int
    
    var body: some View {
        NavigationView {
            
        }
    }
}

