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
        if viewStore.shouldShowProgressIndicator {
          VStack {
            Spacer()
            ActivityIndicator(
              style: .large,
              isAnimating: viewStore.binding(
                get: \.shouldShowProgressIndicator,
                send: UserListAction.enableProgressIndicator
              )
            )
            Spacer()
          }
        } else {
          List(viewStore.users, id: \.id) { user in
            UserView(
              state: .init(
                firstName: user.name.first,
                lastName: user.name.last,
                email: user.email)
            )
            .onAppear {
              viewStore.send(.retrieveNextPageIfNeeded(currentItem: user.id))
            }
          }
        }
      }
      .onAppear {
        viewStore.send(.onAppear)
      }
      .onDisappear {
        viewStore.send(.onDisappear)
      }
    }
  }
}



