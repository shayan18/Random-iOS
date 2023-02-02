//
//  ApiProviderExt.swift
//  RandomTests
//
//  Created by Shayan Ali on 03.02.23.
//

import Foundation
import Microya
@testable import Random

extension ApiProvider {
  static var test: ApiProvider<RandomUserEndPoint> {
    ApiProvider<RandomUserEndPoint>(
      baseUrl: URL(string: "https://randomuser.me")!,
      plugins: [Reachability.test.stateChangePlugin()],
      mockingBehavior: .init(
        delay: TestConstants.requestDelay,
        scheduler: TestConstants.scheduler.eraseToAnyScheduler(),
        mockedResponseProvider: { endpoint in
          switch endpoint {
          case .index(.users, _, _):
            return endpoint.mock(status: .ok, mockedJson: .userPage1)
          }
        }
      )
    )
  }
}

