//
//  UserListStore.swift
//  Random
//
//  Created by Shayan Ali on 01.02.23.
//

import ComposableArchitecture
import Microya
import Foundation

struct UserListState: Equatable {
  var users: IdentifiedArrayOf<User> = []
  var shouldShowProgressIndicator = false
  var serverStatus: Bool = false
  var page = Page(num: 1, items: 20)
  var errorMessage: String = ""
  let includeParams: [String] = ["name","email"]
  
  func loadMoreContentIfNeeded(id: String) -> Bool  {
    let thresholdIndex = users.index(users.endIndex, offsetBy: -5)
    return users.firstIndex(where: { $0.id == id }) == thresholdIndex
  }
}

enum UserListAction: Equatable {
  case onAppear
  case retrieve
  case retrieveNextPageIfNeeded(id: String)
  case enableProgressIndicator(Bool)
  case checkOfflineMode
  case showOfflineView
  case saveRequestedUsers(users: [User])
  case onDisappear
  case networkChanged(networkState: Reachability.State?)
  case receivedUsersResponse(Result<ApiCollectionResponse<User>, ApiError<RandomUserError>>)
}

