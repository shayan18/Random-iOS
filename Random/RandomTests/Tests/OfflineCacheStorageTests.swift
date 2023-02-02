//
//  OfflineCacheStorageTests.swift
//  RandomTests
//
//  Created by Shayan Ali on 03.02.23.
//

@testable import Random
import CoreData
import XCTest

final class OfflineCacheStorageTests: XCTestCase {
  func testStoringAndFetchingUsers() throws {
    let testStorage = OfflineCacheStorage.test
    XCTAssertEqual(try testStorage.context.count(for: CachedUser.fetchRequest()), 0)
    let newUser = CachedUser(context: testStorage.context)
    newUser.id = "1"
    newUser.name = "Shayan"
    newUser.lastname = "Ali"
    newUser.email = "test@demo.com"

    testStorage.save()
    XCTAssertEqual(try testStorage.context.count(for: CachedUser.fetchRequest()), 1)
  }
}

