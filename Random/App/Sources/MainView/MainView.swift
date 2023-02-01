//
//  RandomApp.swift
//  Random
//
//  Created by Shayan Ali on 01.02.23.
//

import ComposableArchitecture
import Microya
import SwiftUI

struct MainView: View {
  let store: Store<AppState, AppAction>
  
  var body: some View {
      AppView(store: store)
  }
}
