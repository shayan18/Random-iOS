//
//  UserListReducer.swift
//  Random
//
//  Created by Shayan Ali on 01.02.23.
//

import ComposableArchitecture
import Foundation
import Microya
import CoreData

let userListReducer = AnyReducer<UserListState, UserListAction, AppEnv>() { state, action, env in
  switch action {
  case .onAppear:
    return .init(value: .retrieve)
    
  case .retrieve:
    state.users = []
    state.page.num = 1
    
    return .merge(
      .init(value: .enableProgressIndicator(true)),
      env.apiProvider
        .publisher(on: .index(.users, page: state.page, includes: []), decodeBodyTo: ApiCollectionResponse<User>.self)
        .receive(on: env.mainQueue)
        .catchToEffect()
        .map { UserListAction.receivedUsersResponse($0)}
        .cancellable(id: Cancellable(), cancelInFlight: true)
    )
    
    
  case .retrieveNextPageIfNeeded(currentItem: let item):
    guard state.loadMoreContentIfNeeded(item: item) else { return .none }
    state.page.num += 1
    
    return env.apiProvider
      .publisher(on: .index(.users, page: state.page, includes: []), decodeBodyTo: ApiCollectionResponse<User>.self)
      .receive(on: env.mainQueue)
      .catchToEffect()
      .map { UserListAction.receivedUsersResponse($0)}
      .cancellable(id: Cancellable(), cancelInFlight: true)
    
  case let .receivedUsersResponse(userResponse):
    switch userResponse {
    case let .success(response):
      state.users.append(contentsOf: IdentifiedArrayOf(uniqueElements: response.results))
      
      let context = env.offlineCacheStorage.context
      for user in response.results {
        let newUser = CachedUser(context: context)
        newUser.id = user.id
        newUser.name = user.name.first
        newUser.lastname = user.name.last
        newUser.email = user.email
      }
      env.offlineCacheStorage.save()
      
      return .init(value: .enableProgressIndicator(false))
      
    case let .failure(error):
      if state.users.isEmpty {
        let context = env.offlineCacheStorage.context
       let request = CachedUser.fetchRequest()
        let offlineUsers = try! env.offlineCacheStorage.context.fetch(request)
        state.cachedUsers = IdentifiedArrayOf(uniqueElements: offlineUsers)
      }
      state.errorMessage = AppError(error: error)?.title ?? ""
      return .init(value: .enableProgressIndicator(false))
    }
    
  case let .enableProgressIndicator(isLoading):
    state.shouldShowProgressIndicator = isLoading
    
  case .onDisappear:
    return .cancel(id: Cancellable())
  }
  
  return .none
}
