//
//  ApiCollectionResponseExt.swift
//  RandomTests
//
//  Created by Shayan Ali on 03.02.23.
//
import Foundation
import Microya
@testable import Random

extension ApiCollectionResponse {
  init(
    mockedJson: MockedJson
  ) {
    do {
      let mockedData = try Data(mockedJson: mockedJson)
      self = try JSONDecoder.randomUserApi.decode(Self.self, from: mockedData)
    }
    catch {
      fatalError("Mocked JSON data could not be converted to type \(Self.self). Error: \(error)")
    }
  }
}

