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
  var users: [User] = []
  var errorMessage: String = ""
  var isLoading = false
  var page = Page(num: 1, items: 10)
}

enum UserListAction: Equatable {
  case onAppear
  case receivedUsersResponse(Result<ApiCollectionResponse<User>, ApiError<RandomUserError>>)
}

