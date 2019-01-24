//
//  Const.swift
//  gankio
//
//  Created by za-wanghe on 2019/1/12.
//  Copyright © 2019 za-wanghe. All rights reserved.
//

import Foundation

struct Const {
    static let HOST = "http://gank.io"
    static let API = "/api/"
    static func getTodayURL() -> String {
        return (HOST + API + "today")
    }
    
    static func getDayURL(date: Date) -> String {
        let calendar = Calendar.current
        if (calendar.isDateInToday(date)) {
            return getTodayURL()
        } else {
            let dateComponents = calendar.dateComponents(in: TimeZone.current, from: date)
            return HOST + API + "day/\(dateComponents.year!)/\(dateComponents.month!)/\(dateComponents.day!)"
        }
    }
    
    static func getHistoryURL() -> String {
        return HOST + API + "day/history"
    }
    
    static func getHistoryContentURL(pageSize: Int, pageNum: Int) -> String {
        return "\(HOST)\(API)history/content/\(pageSize)/\(pageNum)"
    }
}
