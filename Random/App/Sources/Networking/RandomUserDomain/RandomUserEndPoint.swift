//
//  RandomUserEndPoint.swift
//  Random
//
//  Created by Shayan Ali on 01.02.23.
//

import Microya
import Foundation

/// The collection of supported endpoints of the Random user API
enum RandomUserEndPoint {
    case index(
        IndexEndpoint,
        page: Page? = nil,
        includes: [String] = []
    )
    
    /// all endpoints that supports pagination.
    enum IndexEndpoint {
        /// get random users attributes i.e name, lastname, email.
        case users
    }
}

extension RandomUserEndPoint: Endpoint {
    typealias ClientErrorType = RandomUserError
    
    var headers: [String : String] {
        [:]
    }
    
    var subpath: String {
        switch self {
        case .index(.users, _, _):
            return "/api"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .index:
            return .get
        }
    }
    
    var queryParameters: [String: QueryParameterValue] {
        switch self {
        case let .index(_, page, includes):
            return prepareQueryParams(page: page, includes: includes)
        }
    }
    
    private func prepareQueryParams(
        page: Page? = nil,
        includes: [String] = []
    ) -> [String: QueryParameterValue] {
        var queryParams = [String: QueryParameterValue]()
        
        if let page = page {
            queryParams["page"] = QueryParameterValue(stringLiteral: page.num.description)
            queryParams["results"] = QueryParameterValue(stringLiteral: page.items.description)
        }
        
        if !includes.isEmpty {
            queryParams["inc"] = QueryParameterValue(stringLiteral: includes.joined(separator: ","))
        }
        return queryParams
    }
    
    var decoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }
}


