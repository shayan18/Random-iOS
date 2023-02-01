//
//  AppEnv.swift
//  Random
//
//  Created by Shayan Ali on 01.02.23.
//

import ComposableArchitecture
import Foundation
import Microya

struct AppEnv {
  let mainQueue: AnySchedulerOf<DispatchQueue>
  let apiProvider: ApiProvider<RandomUserEndPoint>
}
