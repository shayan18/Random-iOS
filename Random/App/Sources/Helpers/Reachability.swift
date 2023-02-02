//
//  Reachability.swift
//  Random
//
//  Created by Shayan Ali on 02.02.23.
//

import Combine
import Foundation
import Microya
import Network

/// Stores the latest state of reachability to the Internet and our API server and provides global access to it with testing support.
final class Reachability {
  enum State {
    /// The device is not connected to the internet.
    /// This means, neither a WiFi nor a Cellular connection is established.
    case deviceOffline

    /// The device is connected to a network
    /// and on last request the API server was reachable – a 200-499 code response was successfully received.
    case apiServerReachable

    /// The device is connected to a network,
    /// but on last request the API server responded with an internal error status (code 500-599) or a non-JSON body. Server might be offline.
    case apiServerError

    /// The device is connected to a network,
    /// but on last request the API server request timed out without any response.
    /// Either the connectivity is bad, the servers IP blocked or the server offline/overloaded.
    case apiServerUnreachable
  }

  /// The standard object to access the API reachability state in the app.
  static let standard = Reachability()

  #if DEBUG
    /// An reachability object for testing purposes only. No strong reference is held by this static member. Requesting again will return a fresh reachability object.
    static var test: Reachability {
      Reachability()
    }
  #endif

  /// The most recent state based on the success of API requests. Can be `nil` if no requests was sent yet.
  var mostRecentState: State? = .none {
    didSet {
      networkChangedPublisher.send(mostRecentState)
    }
  }

  /// A publisher to subscribe to, when you want to be informed about changes to the network connection.
  var networkChangedPublisher = PassthroughSubject<State?, Never>()

  private init() {}

  func stateChangePlugin() -> StateChangePlugin<RandomUserEndPoint> {
    StateChangePlugin<RandomUserEndPoint>(reachability: self)
  }
}

extension Reachability {
  final class StateChangePlugin<EndpointType: Endpoint>: Plugin<EndpointType> {
    let reachability: Reachability

    init(
      reachability: Reachability
    ) {
      self.reachability = reachability
    }

    override func didPerformRequest<ResultType>(
      urlSessionResult: ApiProvider<EndpointType>.URLSessionResult,
      typedResult: ApiProvider<EndpointType>.TypedResult<ResultType>,
      endpoint: EndpointType
    ) where ResultType: Decodable {
      // List of possible URL errors: https://nshipster.com/nserror/#nsurlerrordomain-cfnetworkerrors
      if let error = urlSessionResult.error as NSError?, error.domain == NSURLErrorDomain {
        switch error.code {
        case NSURLErrorNotConnectedToInternet:
          reachability.mostRecentState = .deviceOffline

        default:  // this covers all other cases, including a connection timeout
          // TODO: [sa_2023-2-02] use a proper logger once available
          print("API request failed with error: \(error)")
          reachability.mostRecentState = .apiServerUnreachable
        }
      }

      if let httpResponse = urlSessionResult.response as? HTTPURLResponse {
        switch httpResponse.statusCode {
        case 500...599:
          reachability.mostRecentState = .apiServerError

        case 200...499:
          if contentTypeIsOtherThanJson(httpResponse: httpResponse) {
            reachability.mostRecentState = .apiServerError
          }
          else {
            reachability.mostRecentState = .apiServerReachable
          }

        default:
          break
        }
      }
    }

    private func contentTypeIsOtherThanJson(httpResponse: HTTPURLResponse) -> Bool {
      guard
        let contentType = httpResponse.value(forHTTPHeaderField: "Content-Type"),
        !contentType.isEmpty
      else {
        return false
      }

      return !contentType.lowercased().contains("json")
    }
  }
}

