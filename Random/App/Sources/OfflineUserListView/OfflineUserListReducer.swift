//
//  OfflineUserListReducer.swift
//  Random
//
//  Created by Shayan Ali on 02.02.23.
//

import ComposableArchitecture
import CoreData
import Foundation

struct OfflineEnv {
  let offlineCacheStorage: OfflineCacheStorage
}

let offlineUserListReducer = AnyReducer<OfflineUserListState, OfflineUserListAction, OfflineEnv>() { state, action, env in
  switch action {
  case .onAppear:
    let context = env.offlineCacheStorage.context
    let request = CachedUser.fetchRequest()
    let offlineUsers = try! env.offlineCacheStorage.context.fetch(request)
    state.cachedUsers = IdentifiedArrayOf(uniqueElements: offlineUsers)
  }
  return .none
}
