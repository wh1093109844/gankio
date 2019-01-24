//
//  DaysPresenterImpl.swift
//  gankio
//
//  Created by za-wanghe on 2019/1/16.
//  Copyright © 2019 za-wanghe. All rights reserved.
//

import Foundation
class DaysPresenterImpl<T: DaysView>: DayPresenter {
    
    private var view: T
    private var initDate: Date?
    private lazy var respository: Respository = {
        return RespositoryManager.respository
    }()
    
    private var history: [Date] = []
    private var daysMap: [String: Response<[String: [Category]]>] = [:]
    private let dateFormatter: DateFormatter
    
    init(view: T, date initDate: Date?) {
        self.view = view
        self.initDate = initDate
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.view.presenter = self as! T.T
    }
    
    func loadDaysDataByDate(date: Date) {
        if let cache = getCache(date: date) {
            view.setDayData(data: cache)
        } else {
            respository.getDataByDate(date: date) {(response, rowResponse, error) -> Void in
                if (error != nil) {
                    print(error?.localizedDescription)
                } else if response != nil {
                    self.view.setDayData(data: response)
                    self.daysMap[self.dateFormatter.string(from: date)] = response
                }
            }
        }
    }
    
    func start() {
        loadDaysDataByDate(date: initDate == nil ? Date() : initDate!)
        requestHistory()
    }
    
    func destory() {
        
    }
    
    private func handleDataResponse(response: Response<[String: [Category]]>?, rowResponse: URLResponse?, error: Error?) {
        if (error == nil) {
            view.setDayData(data: response)
        } else if response != nil {
            view.setDayData(data: response)
        }
    }
    
    private func requestHistory() {
        respository.getHistory() {(response, rowResponse, error) -> Void in
            self.history = []
            guard let results = response?.results else {
                return
            }
            results.forEach() {(item) -> Void in
                if let date = self.dateFormatter.date(from: item) {
                    self.history.append(date)
                }
            }
            self.view.setHistory(history: self.history)
        }
    }
    
    private func getCache(date: Date) -> Response<[String: [Category]]>? {
        let str = dateFormatter.string(from: date)
        return daysMap[str]
    }
}
