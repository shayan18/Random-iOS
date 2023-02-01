//
//  AppError.swift
//  Random
//
//  Created by Shayan Ali on 01.02.23.
//

import Foundation
import Microya

struct AppError: Error, Equatable, Decodable {
    let title: String
    let statusCode: Int

    init(
        _ title: String,
        statusCode: Int = 0
    ) {
        self.title = title
        self.statusCode = statusCode
    }

    init?(
        error: ApiError<RandomUserError>
    ) {
        var code: Int? = 0
        var title: String?
        switch error {
        case let .clientError(statusCode, clientError):
            code = statusCode
            title = clientError?.error

        case let .noResponseReceived(error):
            title = error?.localizedDescription

        case let .serverError(statusCode), let .unexpectedStatusCode(statusCode), let .noDataInResponse(statusCode):
            code = statusCode

        case let .responseDataConversionFailed(_, error):
            title = error.localizedDescription

        case let .unexpectedResponseType(response):
            code = (response as? HTTPURLResponse)?.statusCode

        case .emptyMockedResponse:
            break  // Keep default values for mocked response
        }
        guard let code = code, let title = title else { return nil }

        self.statusCode = code
        self.title = title
    }
}



