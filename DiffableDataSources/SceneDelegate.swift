//
//  SceneDelegate.swift
//  DiffableDataSources
//
//  Created by Joshua Homann on 4/17/21.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = scene as? UIWindowScene else { return }
    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = TabbarController()
    self.window = window
    window.makeKeyAndVisible()
  }
}

