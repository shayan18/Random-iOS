//
//  ApiCollectionResponse.swift
//  Random
//
//  Created by Shayan Ali on 01.02.23.
//

/// The top level response structure of all endpoints providing body data.
struct ApiCollectionResponse<T: Decodable>: Decodable {
    /// The responses 'primary data' where the expected data type differs from endpoint to endpoint, thus it's provided as a generic type. Required.
    let results: [T]
    
    /// A info object that provides additional information on all collection endpoints. Required.
    let info: Info
}

struct Info: Decodable {
    let results: Int
    let page: Int
}
