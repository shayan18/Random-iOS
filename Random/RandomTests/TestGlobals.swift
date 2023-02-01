//
//  TestGlobals.swift
//  RandomTests
//
//  Created by Shayan Ali on 01.02.23.
//

@testable import Random
import Foundation
import Microya

enum TestConstants {
    static let testApiProvider: ApiProvider<RandomUserEndPoint> = .init(
        baseUrl: URL(string: "https://randomuser.me")!
    )
}

