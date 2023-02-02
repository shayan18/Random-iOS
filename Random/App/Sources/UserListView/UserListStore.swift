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
  var cachedUsers: IdentifiedArrayOf<CachedUser> = []
  var shouldShowProgressIndicator = false
  var page = Page(num: 1, items: 20)
  var errorMessage: String = ""
  
  func loadMoreContentIfNeeded(item: UUID) -> Bool  {
    let thresholdIndex = users.index(users.endIndex, offsetBy: -5)
    return users.firstIndex(where: { $0.id == item }) == thresholdIndex
  }
}

enum UserListAction: Equatable {
  case onAppear
  case retrieve
  case retrieveNextPageIfNeeded(currentItem: UUID)
  case enableProgressIndicator(Bool)
  case onDisappear
  case receivedUsersResponse(Result<ApiCollectionResponse<User>, ApiError<RandomUserError>>)
}

