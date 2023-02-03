//
//  UserView.swift
//  RandomTests
//
//  Created by Shayan Ali on 03.02.23.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import Random

final class UserViewTests: XCTestCase {
  func testUserView() {
    let view = UserView(
      state: UserState(firstName: "Shayan", lastName: "Ali", email: "syed.shayan18@gmail"))
    assertScreenshot(variant: "Setup", view: view, width: 250, height: 50)
  }
}

