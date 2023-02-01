//
//  SceneDelegate.swift
//  Random
//
//  Created by Shayan Ali on 01.02.23.
//

import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      window.rootViewController = UIHostingController(rootView: Text("Hello"))
      self.window = window
      window.makeKeyAndVisible()
    }
  }
}

