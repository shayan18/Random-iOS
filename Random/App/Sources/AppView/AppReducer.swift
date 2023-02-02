//
//  AppReducer.swift
//  Random
//
//  Created by Shayan Ali on 01.02.23.
//

import ComposableArchitecture

let appReducer = AnyReducer.combine(
  offlineUserListReducer
    .optional()
    .pullback(
      state: \AppState.offlineUserListState,
      action: /AppAction.offlineUserList(action:),
      environment: { _ in OfflineEnv(offlineCacheStorage: .standard) }
    ),
  userListReducer
    .optional()
    .pullback(
      state: \AppState.userListState,
      action: /AppAction.userList(action:),
      environment: { $0 }
    ),
  AnyReducer<AppState, AppAction, AppEnv>() { state, action, env in
    switch action {
    case .didAppear:
      state.userListState = .init()
      
    case .userList(action: .showOfflineView):
      state.userListState = nil
      state.offlineUserListState = .init()
      
    case .userList, .offlineUserList:
      break // actions handle by respective reducers
    }
    return .none
  }
)


