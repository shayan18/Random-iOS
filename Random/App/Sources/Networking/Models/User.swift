//
//  User.swift
//  Random
//
//  Created by Shayan Ali on 01.02.23.
//

import Foundation

/// The user response object.
struct User: Decodable, Equatable, Identifiable {
  /// The unique identifier for the given object. Required.
  let id = UUID()
  
  /// The name of user.
  let name: Name
  
  /// The user email address.
  let email: String
}

/// The user name object.
struct Name: Decodable, Equatable {
  let first: String
  let last: String
}
