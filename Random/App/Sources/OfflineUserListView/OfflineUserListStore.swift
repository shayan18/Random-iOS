//
//  OfflineUserListStore.swift
//  Random
//
//  Created by Shayan Ali on 02.02.23.
//

import ComposableArchitecture
import Microya
import Foundation

struct OfflineUserListState: Equatable {
  var cachedUsers: IdentifiedArrayOf<CachedUser> = []
  
}

enum OfflineUserListAction: Equatable {
  case onAppear
}


