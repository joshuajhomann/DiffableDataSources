//
//  PokemonTableViewCell.swift
//  DiffableDataSources
//
//  Created by Joshua Homann on 4/17/21.
//

import UIKit
import Nuke

final class PokemonTableViewCell:  UITableViewCell {
  static let reuseIdentifier = String(describing: UITableViewCell.self)
  private let pokemonView = PokemonView()
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    pokemonView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(pokemonView)
    NSLayoutConstraint.activate([
      pokemonView.topAnchor.constraint(equalTo: contentView.topAnchor),
      pokemonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      pokemonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      pokemonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
    ])
  }
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  func configure(with pokemon: Pokemon) {
    pokemonView.configure(with: pokemon)
  }
}

final class PokemonCollectionViewCell:  UICollectionViewCell {
  static let reuseIdentifier = String(describing: UITableViewCell.self)
  private let pokemonView = PokemonView()
  override init(frame: CGRect) {
    super.init(frame: frame)
    pokemonView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(pokemonView)
    NSLayoutConstraint.activate([
      pokemonView.topAnchor.constraint(equalTo: contentView.topAnchor),
      pokemonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      pokemonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      pokemonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
    ])
  }
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  func configure(with pokemon: Pokemon) {
    pokemonView.configure(with: pokemon)
  }
}


final class PokemonView: UIView {
  private let nameLabel = UILabel()
  private let descriptionLabel = UILabel()
  private let pokemonImageView = UIImageView()
  override init(frame: CGRect) {
    super.init(frame: frame)
    nameLabel.font = UIFont.preferredFont(forTextStyle: .title3)
    nameLabel.numberOfLines = 0
    nameLabel.lineBreakMode = .byWordWrapping
    descriptionLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
    descriptionLabel.numberOfLines = 0
    descriptionLabel.lineBreakMode = .byWordWrapping
    pokemonImageView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    pokemonImageView.backgroundColor = .systemGray6
    pokemonImageView.clipsToBounds = true
    pokemonImageView.layer.cornerRadius = 12
    let vStack = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel])
    vStack.axis = .vertical
    let stack = UIStackView(arrangedSubviews: [pokemonImageView, vStack])
    stack.alignment = .top
    stack.spacing = 12
    stack.translatesAutoresizingMaskIntoConstraints = false
    addSubview(stack)
    NSLayoutConstraint.activate([
      stack.topAnchor.constraint(equalTo: topAnchor, constant: 12),
      stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
      stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
      stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
      pokemonImageView.widthAnchor.constraint(equalToConstant: 64),
      pokemonImageView.widthAnchor.constraint(equalTo: pokemonImageView.heightAnchor)
    ])
  }
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  func configure(with pokemon: Pokemon) {
    nameLabel.text = pokemon.name
    descriptionLabel.text = pokemon.pokemonDescription
    Nuke.loadImage(with: pokemon.artURL, into: pokemonImageView)
  }
}
