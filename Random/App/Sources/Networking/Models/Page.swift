//
//  Page.swift
//  Random
//
//  Created by Shayan Ali on 01.02.23.
//

/// Specifies the requests slice of objects in a list endpoint.
struct Page: Equatable {
    /// The page num.
    var num: Int
    
    /// The number of items requested.
    var items: Int
    
    /// Initializes a new `Page` object with given values. Only `num` is required, uses sensible defaults for `items`.
    init(
        num: Int,
        items: Int = 15
    ) {
        self.num = num
        self.items = items
    }
}
