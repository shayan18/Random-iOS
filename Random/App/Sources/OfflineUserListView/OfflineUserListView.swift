//
//  OfflineUserListView.swift
//  Random
//
//  Created by Shayan Ali on 02.02.23.
//

import ComposableArchitecture
import SwiftUI

struct OfflineUserListView: View {
  let store: Store<OfflineUserListState, OfflineUserListAction>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      NavigationView {
        List(viewStore.cachedUsers, id: \.id) { user in
          UserView(
            state: .init(
              firstName: user.name!,
              lastName: user.lastname!,
              email: user.email!)
          )
        }
        .onAppear {
          viewStore.send(.onAppear)
        }
      }
    }
  }
}



