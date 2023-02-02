//
//  JsonDecoderExt.swift
//  Random
//
//  Created by Shayan Ali on 03.02.23.
//

import Foundation

extension JSONDecoder {
  /// The JSONDecoder for responses received from the Random User API.
  public static var randomUserApi: JSONDecoder {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .iso8601
    return decoder
  }
}
