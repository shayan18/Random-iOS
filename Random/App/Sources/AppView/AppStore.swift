//
//  AppStore.swift
//  Random
//
//  Created by Shayan Ali on 01.02.23.
//
import Foundation

struct AppState: Equatable {
  var userListState: UserListState?
  var offlineUserListState: OfflineUserListState?
}

enum AppAction: Equatable {
  case didAppear
  case userList(action: UserListAction)
  case offlineUserList(action: OfflineUserListAction)
}
