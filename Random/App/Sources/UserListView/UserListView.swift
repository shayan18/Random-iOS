//
//  UserListView.swift
//  Random
//
//  Created by Shayan Ali on 01.02.23.
//

import ComposableArchitecture
import SwiftUI

struct UserListView: View {
  let store: Store<UserListState, UserListAction>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      NavigationView {
        ScrollView(.vertical) {
          ForEach(viewStore.users, id: \.id) { user in
            UserView(
              state: .init(
                firstName: user.name.first,
                lastName: user.name.last,
                email: user.email)
            )
          }
        }
      }
      .onAppear {
        viewStore.send(.onAppear)
      }
    }
  }
}


