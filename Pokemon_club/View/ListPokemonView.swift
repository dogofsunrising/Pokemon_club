//
//  ListView.swift
//  Pokemon_club
//
//  Created by 藤本皇汰 on 2024/03/27.
//

import SwiftUI

struct PokemonListView: View {
    @ObservedObject var viewModel = PokemonViewModel()
    let pokemon: Pokemon
    @State var name:String = ""
    
    var body: some View {
        HStack{
            Text(String(format: "%d", pokemon.id))
            Text(name)
        }.onAppear{
            viewModel.OneSpecieFunction(url_s: pokemon.species.url){ specie in
                for na in specie.names{
                    if na.language.name == "ja-Hrkt" {
                        name = na.name
                    }
                }
            }
        }
    }
}
