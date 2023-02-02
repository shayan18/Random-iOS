//
//  AppEnvExt.swift
//  RandomTests
//
//  Created by Shayan Ali on 03.02.23.
//

@testable import Random
import Foundation

extension AppEnv {
  static let test: Self = .init(
    mainQueue: TestConstants.scheduler.eraseToAnyScheduler(),
    apiProvider: .test,
    offlineCacheStorage: .test,
    reachability: .test
  )
}
