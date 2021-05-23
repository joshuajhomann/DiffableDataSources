//
//  PokemonView.swift
//  DiffableDataSources
//
//  Created by Joshua Homann on 4/24/21.
//

import Combine
import SwiftUI

// MARK: - PokemonView
struct PokemonSwiftUIView: View {
  // MARK: - Instance
  @StateObject private var viewModel = PokemonViewModel()

  // MARK: - View
  var body: some View {
    VStack {
      TextField("Search...", text: $viewModel.searchTerm)
        .padding(4)
        .background(Color(.systemGray5))
        .cornerRadius(8)
        .padding(4)
      List(viewModel.pokemon) { pokemon in
        HStack(alignment: .top, spacing: 12) {
          ImageView(url: pokemon.artURL)
            .frame(width: 64, height: 64)
            .cornerRadius(12)
          VStack {
            Text(pokemon.name)
              .font(.title)
            Text(pokemon.pokemonDescription)
              .font(.caption)
          }
        }
      }
    }
  }
}
