//
//  UserListStore.swift
//  Random
//
//  Created by Shayan Ali on 01.02.23.
//

import ComposableArchitecture
import Microya

struct UserListState: Equatable {
    var users: [User] = []
    var errorMessage: String = ""
    var isLoading = false
}

enum UserListAction: Equatable {
    case onAppear
    case receivedUsersResponse(Result<ApiCollectionResponse<User>, ApiError<RandomUserError>>)
}
