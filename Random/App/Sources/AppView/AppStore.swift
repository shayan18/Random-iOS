//
//  AppStore.swift
//  Random
//
//  Created by Shayan Ali on 01.02.23.
//
import Foundation

struct AppState: Equatable {
  var userListState: UserListState?
  
}

enum AppAction: Equatable {
  case didAppear
  case userList(action: UserListAction)
}
