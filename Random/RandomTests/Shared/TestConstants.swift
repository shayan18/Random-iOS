//
//  TestConstants.swift
//  RandomTests
//
//  Created by Shayan Ali on 03.02.23.
//

import Foundation
import ComposableArchitecture
import Microya
@testable import Random

enum TestConstants {
  /// The delay to put on API requests returning a result.
  static let requestDelay: DispatchQueue.SchedulerTimeType.Stride = .milliseconds(300)

  /// The test scheduler to control time in tests.
  static let scheduler: TestScheduler = DispatchQueue.test
  
  static let testApiProvider: ApiProvider<RandomUserEndPoint> = .init(
      baseUrl: URL(string: "https://randomuser.me")!
  )
}

