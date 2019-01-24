//
//  GankIORespository.swift
//  gankio
//
//  Created by za-wanghe on 2019/1/16.
//  Copyright © 2019 za-wanghe. All rights reserved.
//

import Foundation

class GankIORespository: Respository {
    
    func getHistoryData(pageNum: Int, pageSize: Int, callback: @escaping (Response<[Content]>?, URLResponse?, Error?) -> Void) {
        let url = Const.getHistoryContentURL(pageSize: pageSize, pageNum: pageNum)
        HttpHelper.get(url: url, callback: callback)
    }
    
    
    func getDataByDate(date: Date, callback: @escaping (Response<[String : [Category]]>?, URLResponse?, Error?) -> Void) {
        let url = Const.getDayURL(date: date)
        HttpHelper.get(url: url, callback: callback)
    }
    
    func getHistory(callback: @escaping (Response<[String]>?, URLResponse?, Error?) -> Void) {
        let url = Const.getHistoryURL()
        HttpHelper.get(url: url, callback: callback)
    }
}
