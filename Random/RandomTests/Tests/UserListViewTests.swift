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
  
  func testFetchRandomUserPage2() {
    var userListstate = UserListState()
    var preFetchedUsers: IdentifiedArrayOf<User> =  IdentifiedArrayOf(uniqueElements: ApiCollectionResponse(mockedJson: .userPage1).results)
    userListstate.users = preFetchedUsers
    
    let store = TestStore(initialState: userListstate, reducer: userListReducer, environment: .test)
    
    store.send(.retrieveNextPageIfNeeded(id: "testdemo@demo.com")) {
      $0.page.num = 2
    }
    
    TestConstants.scheduler.advance(by: TestConstants.requestDelay)
    
    store.receive(.receivedUsersResponse(.success(ApiCollectionResponse(mockedJson: .userPage2)))) {
      
      preFetchedUsers.append(contentsOf: IdentifiedArrayOf(uniqueElements: ApiCollectionResponse(mockedJson: .userPage2).results))
      
      $0.users =  preFetchedUsers
    }
    
    store.receive(.enableProgressIndicator(false))
    store.receive(.saveRequestedUsers(users: ApiCollectionResponse(mockedJson: .userPage2).results))
  }
}

