//
//  RandomUserError.swift
//  Random
//
//  Created by Shayan Ali on 01.02.23.
//

/// Represents a single error with some additional information on what's wrong.
struct RandomUserError: Decodable, Equatable {
   let error: String
}
