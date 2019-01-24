//
//  Response.swift
//  sinowel
//
//  Created by za-wanghe on 2019/1/11.
//  Copyright © 2019 za-wanghe. All rights reserved.
//

import Foundation

struct Response<T: Codable>: Codable {
    var error: Bool
    var results: T?
    var category: [String]?
}
