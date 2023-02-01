//
//  UserListReducer.swift
//  Random
//
//  Created by Shayan Ali on 01.02.23.
//

import ComposableArchitecture
import Foundation
import Microya

let userListReducer = AnyReducer<UserListState, UserListAction, AppEnv>() { state, action, env in
  switch action {
  case .onAppear:
    return env.apiProvider
      .publisher(on: .index(.users, page: state.page, includes: []), decodeBodyTo: ApiCollectionResponse<User>.self)
      .receive(on: env.mainQueue)
      .catchToEffect()
      .map { UserListAction.receivedUsersResponse($0)}
      .cancellable(id: Cancellable(), cancelInFlight: true)
    
  case let .receivedUsersResponse(userResponse):
    switch userResponse {
    case let .success(response):
      state.users = response.results
      
    case let .failure(error):
      state.errorMessage = AppError(error: error)?.title ?? ""
    }
  }
  return .none
}
