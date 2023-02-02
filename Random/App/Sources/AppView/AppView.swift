//
//  ContentView.swift
//  Random
//
//  Created by Shayan Ali on 01.02.23.
//

import ComposableArchitecture
import SwiftUI

struct AppView: View {
  let store: Store<AppState, AppAction>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      Group {
        IfLetStore(
          store.scope(
            state: \.offlineUserListState,
            action: AppAction.offlineUserList(action:)
          ),
          then: OfflineUserListView.init(store:)
        )
        IfLetStore(
          store.scope(
            state: \.userListState,
            action: AppAction.userList(action:)
          ),
          then: UserListView.init(store:)
        )
      }
      .onAppear {
        viewStore.send(.didAppear)
      }
    }
  }
}
