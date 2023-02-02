//
//  RandomTests.swift
//  RandomTests
//
//  Created by Shayan Ali on 01.02.23.
//

import ComposableArchitecture
import XCTest
@testable import Random

final class UserListViewTests: XCTestCase {
  func testFetchRandomUsersWithSuccess() {
    let store = TestStore(initialState: .init(), reducer: userListReducer, environment: .test)
    
    store.send(.onAppear)
    store.receive(.retrieve)
    TestConstants.scheduler.advance(by: TestConstants.requestDelay)
    
    store.receive(.enableProgressIndicator(true)) {
      $0.shouldShowProgressIndicator = true
    }
    
    store.receive(.receivedUsersResponse(.success(ApiCollectionResponse(mockedJson: .userPage1)))) {
      $0.users = IdentifiedArrayOf(uniqueElements: ApiCollectionResponse(mockedJson: .userPage1).results)
      $0.shouldShowProgressIndicator = true
    }
    
    store.receive(.enableProgressIndicator(false)) {
      $0.shouldShowProgressIndicator = false
    }
    
    store.receive(.saveRequestedUsers(users: ApiCollectionResponse(mockedJson: .userPage1).results))
  }
}

