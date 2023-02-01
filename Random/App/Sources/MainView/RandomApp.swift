//
//  RandomApp.swift
//  Random
//
//  Created by Shayan Ali on 01.02.23.
//

import ComposableArchitecture
import Microya
import SwiftUI

struct RandomApp: View {
  let store: Store<AppState, AppAction>
  let env: AppEnv
  
  init() {
    
    let baseUrl: URL = {
      #if DEBUG
        return URL(string: "https://randomuser.me")!
      #else
        return URL(string: "https://randomuser.me")!
      #endif
    }()
    
    self.env = AppEnv(
        mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
        apiProvider: ApiProvider<RandomUserEndPoint>(
            baseUrl: baseUrl
        ))
    
    self.store = Store(
        initialState: AppState(),
        reducer: .empty,
        environment: self.env
    )
  }
  
  var body: some View {
      AppView(store: store)
  }
}
