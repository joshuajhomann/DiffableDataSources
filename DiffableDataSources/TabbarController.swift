//
//  TabbarController.swift
//  DiffableDataSources
//
//  Created by Joshua Homann on 4/17/21.
//

import SwiftUI
import UIKit

final class TabbarController: UITabBarController {
  init() {
    super.init(nibName: nil, bundle: nil)
    let mvvm = UINavigationController(rootViewController: PokemonMVVMViewController(viewModel: .init()))
    mvvm.tabBarItem.title = "MVVM"
    mvvm.tabBarItem.image = UIImage(systemName: "square")
    addChild(mvvm)

    let diff = UINavigationController(rootViewController: PokemonDiffableViewController())
    diff.tabBarItem.title = "Diffable"
    diff.tabBarItem.image = UIImage(systemName: "star")
    addChild(diff)

    let mvc = UINavigationController(rootViewController: PokemonMVCViewController())
    mvc.tabBarItem.title = "MVC"
    mvc.tabBarItem.image = UIImage(systemName: "circle")
    addChild(mvc)

    let suv = UINavigationController(rootViewController:UIHostingController(rootView: PokemonSwiftUIView()))
    suv.tabBarItem.title = "SwiftUI"
    suv.tabBarItem.image = UIImage(systemName: "pencil")
    addChild(suv)

    let cv = UINavigationController(rootViewController: PokemonCollectionViewController(viewModel: .init()))
    cv.tabBarItem.title = "List"
    cv.tabBarItem.image = UIImage(systemName: "phone")
    addChild(cv)

  }
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
