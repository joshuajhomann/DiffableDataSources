//
//  PokemonMVCViewController.swift
//  DiffableDataSources
//
//  Created by Joshua Homann on 4/17/21.
//

import UIKit

final class PokemonMVCViewController: UIViewController {
  private let tableView = UITableView()
  private let searchBar = UISearchBar()
  private var pokemon: [Pokemon] = Pokemon.all
  init() {
    super.init(nibName: nil, bundle: nil)
    view.backgroundColor = .systemBackground
    searchBar.searchTextField.addTarget(self, action: #selector(search), for: .editingChanged)
    navigationItem.title = "MVC"
    tableView.translatesAutoresizingMaskIntoConstraints = false
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(searchBar)
    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
    tableView.dataSource = self
    tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: PokemonTableViewCell.reuseIdentifier)
  }

  @objc private func search() {
    let text = searchBar.searchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    defer { tableView.reloadData() }
    guard !text.isEmpty else { return pokemon = Pokemon.all }
    pokemon = Pokemon.all.filter { pokemon in
      pokemon.name.range(of: text, options: .caseInsensitive) != nil ||
      pokemon.pokemonDescription.range(of: text, options: .caseInsensitive) != nil
    }
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension PokemonMVCViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    pokemon.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.reuseIdentifier, for: indexPath)
    (cell as? PokemonTableViewCell)?.configure(with: pokemon[indexPath.row])
    return cell
  }
}

