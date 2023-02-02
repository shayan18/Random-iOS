//
//  RandomUsersApiTests.swift
//  RandomTests
//
//  Created by Shayan Ali on 01.02.23.
//

@testable import Random
import Microya
import XCTest

final class RandomUsersApiTests: XCTestCase {
    func testFetchRandomUsersAttributes() throws {
        let usersResponseBody =
        try TestConstants.testApiProvider.performRequestAndWait(
            on: .index(.users),
            decodeBodyTo: ApiCollectionResponse<User>.self
        )
        .get()
        
        usersResponseBody.results.forEach { userResponse in
            XCTAssertNotNil(userResponse.name.first)
            XCTAssertNotNil(userResponse.name.last)
            XCTAssertNotNil(userResponse.email)
        }
    }
    
    func testFetchRandomUsersAttributesWithPagination() throws {
        let usersResponseBody =
        try TestConstants.testApiProvider.performRequestAndWait(
            on: .index(.users, page: Page(num: 1, items: 20)),
            decodeBodyTo: ApiCollectionResponse<User>.self
        )
        .get()
        XCTAssertEqual(usersResponseBody.results.count, 20)
        XCTAssertTrue(usersResponseBody.info.page == 1)
        
        usersResponseBody.results.forEach { userResponse in
            XCTAssertNotNil(userResponse.name.first)
            XCTAssertNotNil(userResponse.name.last)
            XCTAssertNotNil(userResponse.email)
        }
    }
    
    func testFetchRandomUsersWithWrongOutputAssertion() throws {
        let usersResponseBody =
        try TestConstants.testApiProvider.performRequestAndWait(
            on: .index(.users, page: .init(num: 2)),
            decodeBodyTo: ApiCollectionResponse<User>.self
        )
        .get()
        XCTAssertNotEqual(usersResponseBody.results.count, 20)
        XCTAssertFalse(usersResponseBody.info.page == 1)
    }
}
