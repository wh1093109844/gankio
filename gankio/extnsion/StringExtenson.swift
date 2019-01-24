//
//  StringExtenson.swift
//  gankio
//
//  Created by za-wanghe on 2019/1/21.
//  Copyright © 2019 za-wanghe. All rights reserved.
//

import Foundation

extension StringProtocol {
    
}
extension TimeZone {
    static var chinaTimeZone: TimeZone {
        var timeZone = TimeZone(identifier: "Asia/Shanghai") ?? TimeZone.current
        return timeZone
    }
}
