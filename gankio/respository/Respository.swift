//
//  Respository.swift
//  gankio
//
//  Created by za-wanghe on 2019/1/16.
//  Copyright © 2019 za-wanghe. All rights reserved.
//

import Foundation

protocol Respository {
    func getDataByDate(date: Date, callback: @escaping (Response<[String:[Category]]>?, URLResponse?, Error?) -> Void)
    func getHistory(callback: @escaping (Response<[String]>?, URLResponse?, Error?) -> Void)
    
    func getHistoryData(pageNum: Int, pageSize: Int, callback: @escaping (Response<[Content]>?, URLResponse?, Error?) -> Void)
}
