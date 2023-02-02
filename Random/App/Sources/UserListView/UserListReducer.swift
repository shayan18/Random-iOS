//
//  UserListReducer.swift
//  Random
//
//  Created by Shayan Ali on 01.02.23.
//

import ComposableArchitecture
import Foundation
import Microya

let userListReducer = AnyReducer<UserListState, UserListAction,  AppEnv>() { state, action, env in
  switch action {
  case .onAppear:
    return .init(value: .retrieve)
    
  case .retrieve:
    return .merge(
      .init(value: .enableProgressIndicator(true)),
      EffectTask(env.reachability.networkChangedPublisher)
        .map(UserListAction.networkChanged)
        .receive(on: env.mainQueue)
        .eraseToEffect()
        .cancellable(id: NetworkChangedPublisherId(), cancelInFlight: true),
      
      env.apiProvider
        .publisher(on: .index(.users, page: state.page, includes: state.includeParams), decodeBodyTo: ApiCollectionResponse<User>.self)
        .receive(on: env.mainQueue)
        .catchToEffect()
        .map { UserListAction.receivedUsersResponse($0)}
        .cancellable(id: Cancellable(), cancelInFlight: true)
    )
    
  case let .retrieveNextPageIfNeeded(id):
    guard state.loadMoreContentIfNeeded(id: id) else { return .none }
    state.page.num += 1
    
    return env.apiProvider
      .publisher(on: .index(.users, page: state.page, includes: state.includeParams), decodeBodyTo: ApiCollectionResponse<User>.self)
      .receive(on: env.mainQueue)
      .catchToEffect()
      .map { UserListAction.receivedUsersResponse($0)}
      .cancellable(id: Cancellable(), cancelInFlight: true)
    
  case let .receivedUsersResponse(userResponse):
    switch userResponse {
    case let .success(response):
      state.users.append(contentsOf: IdentifiedArrayOf(uniqueElements: response.results))
      
      return .merge(
        .init(value: .enableProgressIndicator(false)),
        .init(value: .saveRequestedUsers(users: response.results))
      )
      
    case let .failure(error):
      state.errorMessage = AppError(error: error)?.title ?? ""
      
      return .init(value: .enableProgressIndicator(false))
    }
    
  case let .enableProgressIndicator(isLoading):
    state.shouldShowProgressIndicator = isLoading
    
  case let .networkChanged(networkState):
    switch networkState {
    case .deviceOffline, .apiServerError, .apiServerUnreachable:
      state.serverStatus = false
      
    case .apiServerReachable, .none:
      state.serverStatus = true
    }
    return .init(value: .checkOfflineMode)
    
  case .checkOfflineMode:
    if !state.serverStatus {
      return .init(value: .showOfflineView)
    }
    return
      .cancel(id: NetworkChangedPublisherId())
    
  case let .saveRequestedUsers(users):
    let context = env.offlineCacheStorage.context
    for user in users {
      let newUser = CachedUser(context: context)
      newUser.id = user.id
      newUser.name = user.name.first
      newUser.lastname = user.name.last
      newUser.email = user.email
    }
    
    env.offlineCacheStorage.save()
    return
      .cancel(id: NetworkChangedPublisherId())
    
  case .onDisappear:
    return .merge(
      .cancel(id: Cancellable()),
      .cancel(id: NetworkChangedPublisherId())
    )
    
  case .showOfflineView:
    break // Handler by parent reducer
  }
  return .none
}
