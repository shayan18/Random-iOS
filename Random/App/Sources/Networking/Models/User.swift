//
//  User.swift
//  Random
//
//  Created by Shayan Ali on 01.02.23.
//

/// The user response object.
struct User: Decodable {
    /// The name of user.
    let name: Name
    
    /// The user email address.
    let email: String
}

/// The user name object.
struct Name: Decodable {
    let first: String
    let last: String
}
