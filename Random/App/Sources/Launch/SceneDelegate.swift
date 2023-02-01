//
//  SceneDelegate.swift
//  Random
//
//  Created by Shayan Ali on 01.02.23.
//

import SwiftUI
import UIKit
import ComposableArchitecture
import Microya

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    
    let baseUrl: URL = {
#if DEBUG
      return AppConstants.serverBaseUrl
#else
      return AppConstants.serverBaseUrl
#endif
    }()
    let appEnv = AppEnv(
      mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
      apiProvider: ApiProvider<RandomUserEndPoint>(
        baseUrl: baseUrl
      ))
    
    let store = Store(initialState: .init(), reducer: appReducer, environment: appEnv)
    let mainView = MainView(store: store)
    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      window.rootViewController = UIHostingController(rootView: mainView)
      self.window = window
      window.makeKeyAndVisible()
    }
  }
}
