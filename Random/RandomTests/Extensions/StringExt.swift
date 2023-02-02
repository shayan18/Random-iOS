//
//  StringExt.swift
//  RandomTests
//
//  Created by Shayan Ali on 03.02.23.
//

extension StringProtocol {
  var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
}
