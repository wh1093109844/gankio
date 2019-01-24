//
//  Category.swift
//  gankio
//
//  Created by za-wanghe on 2019/1/12.
//  Copyright © 2019 za-wanghe. All rights reserved.
//

import Foundation

struct Category: Codable {
    var _id: String?
    var createdAt: Date?
    var images: [String]?
    var publishedAt: Date?
    var type: String?
    var url: String?
    var who: String?
    var desc: String?
    var source: String?
    var used: Bool
}
