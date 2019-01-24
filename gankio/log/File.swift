//
//  File.swift
//  gankio
//
//  Created by za-wanghe on 2019/1/12.
//  Copyright © 2019 za-wanghe. All rights reserved.
//

import Foundation

class Log {
    static func log(item: Any, _ file: String = #file, _ line: Int = #line, _ function: String = #function) {
        print(item)
    }
    
    static func i(item: Any) {
        log(item: item)
    }
    
    static func d(item: Any) {
        log(item: item)
    }
}
