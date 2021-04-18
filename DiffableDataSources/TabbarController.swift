//
//  TabbarController.swift
//  DiffableDataSources
//
//  Created by Joshua Homann on 4/17/21.
//

import UIKit

final class TabbarController: UITabBarController {
  init() {
    super.init(nibName: nil, bundle: nil)
    let mvc = UINavigationController(rootViewController: PokemonMVCViewController())
    addChild(mvc)
  }
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
