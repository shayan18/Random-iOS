//
//  DataExt.swift
//  RandomTests
//
//  Created by Shayan Ali on 03.02.23.
//

import Foundation

extension Data {
  init(
    mockedJson: MockedJson
  ) throws {
    guard
      let jsonFileUrl = Bundle(for: UserListViewTests.self)
        .url(
          forResource: mockedJson.rawValue.firstUppercased,
          withExtension: "json"
        )
    else {
      fatalError("Reading mocked JSON data failed. File expected at: \(mockedJson.rawValue.firstUppercased).json")
    }

    self = try Data(contentsOf: jsonFileUrl)
  }
}
