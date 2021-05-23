//
//  PokemonCollectionViewController.swift
//  DiffableDataSources
//
//  Created by Joshua Homann on 4/24/21.
//

import Combine
import UIKit

final class PokemonCollectionViewController: UIViewController {
  private var subscriptions = Set<AnyCancellable>()

  private enum Section: Hashable, CaseIterable {
    case pokemon
  }
  private typealias DataSource = UICollectionViewDiffableDataSource<Section, Pokemon>
  private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Pokemon>

  init(viewModel: PokemonViewModel) {
    super.init(nibName: nil, bundle: nil)
    view.backgroundColor = .systemBackground
    let layoutConfig = UICollectionLayoutListConfiguration(appearance: .plain)
    let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: listLayout)
    let searchBar = UISearchBar()
    navigationItem.title = "MVVM"
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(searchBar)
    view.addSubview(collectionView)
    NSLayoutConstraint.activate([
      searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])

    let dataSource = DataSource(
      collectionView: collectionView,
      cellProvider: { (collectionView, indexPath, pokemon) in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.reuseIdentifier, for: indexPath)
        (cell as? PokemonCollectionViewCell)?.configure(with: pokemon)
        return cell
      })
    searchBar.searchTextField.textPublisher.compactMap { $0 }
      .assign(to: &viewModel.$searchTerm)

    viewModel.$pokemon
      .sink(receiveValue: { pokemon in
        var snapshot = Snapshot()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(pokemon, toSection: .pokemon)
        dataSource.apply(snapshot, animatingDifferences: true)
      })
      .store(in: &subscriptions)

    collectionView.dataSource = dataSource
    collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: PokemonCollectionViewCell.reuseIdentifier)
  }
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
