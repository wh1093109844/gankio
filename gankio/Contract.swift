//
//  Contract.swift
//  gankio
//
//  Created by za-wanghe on 2019/1/16.
//  Copyright © 2019 za-wanghe. All rights reserved.
//

import Foundation

protocol Presenter {
    func start()
    func destory()
}

protocol View {
    associatedtype T: Presenter
    var presenter: T? { get set }
}

protocol DayPresenter: Presenter {
    func loadDaysDataByDate(date: Date)
}

protocol DaysView: View where T: DayPresenter {
    func setDayData(data: Response<[String: [Category]]>?)
    func setHistory(history: [Date]?)
}

protocol HistContentPresenter: Presenter {
    func loadNextPage()
}

protocol HistContentView: View where T: HistContentPresenter {
    func addHistContentList(contents: [Content]?)
}
