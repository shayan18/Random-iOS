//
//  AppReducer.swift
//  Random
//
//  Created by Shayan Ali on 01.02.23.
//

import ComposableArchitecture

let appReducer = AnyReducer.combine(
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
        
    case .userList:
        break
    }
    return .none
}
)
    

