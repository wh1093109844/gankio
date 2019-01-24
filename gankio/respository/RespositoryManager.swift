//
//  RespositoryManager.swift
//  gankio
//
//  Created by za-wanghe on 2019/1/16.
//  Copyright © 2019 za-wanghe. All rights reserved.
//

import Foundation

class RespositoryManager {
    private static var _respository: Respository = {
        return GankIORespository()
    }()
    
    static var respository: Respository {
        get {
            return _respository
        }
        set {
            _respository = newValue
        }
    }
}
