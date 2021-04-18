//
//  PokemonDiffableViewController.swift
//  DiffableDataSources
//
//  Created by Joshua Homann on 4/17/21.
//

import CombineCocoa
import Combine
import UIKit

final class PokemonDiffableViewController: UIViewController {
  private var subscriptions = Set<AnyCancellable>()
  private enum Section: Hashable, CaseIterable {
    case pokemon
  }
  private typealias DataSource = UITableViewDiffableDataSource<Section, Pokemon>
  private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Pokemon>

  init() {
    super.init(nibName: nil, bundle: nil)
    view.backgroundColor = .systemBackground
    let tableView = UITableView()
    let searchBar = UISearchBar()
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

    let dataSource = DataSource(
      tableView: tableView,
      cellProvider: { (tableView, indexPath, pokemon) in
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.reuseIdentifier, for: indexPath)
        (cell as? PokemonTableViewCell)?.configure(with: pokemon)
        return cell
      })

    searchBar
      .searchTextField
      .textPublisher
      .receive(on: DispatchQueue.global(qos: .userInitiated))
      .compactMap { $0 }
      .map { text in
        Pokemon.all.filter { pokemon in
          pokemon.name.range(of: text, options: .caseInsensitive) != nil ||
          pokemon.pokemonDescription.range(of: text, options: .caseInsensitive) != nil
        }
      }
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { pokemon in
        var snapshot = Snapshot()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(pokemon, toSection: .pokemon)
        dataSource.apply(snapshot, animatingDifferences: true)
      })
      .store(in: &subscriptions)

    tableView.dataSource = dataSource
    tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: PokemonTableViewCell.reuseIdentifier)
  }
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
