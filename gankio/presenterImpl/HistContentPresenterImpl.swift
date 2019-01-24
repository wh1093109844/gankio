//
//  HistContentPresenterImpl.swift
//  gankio
//
//  Created by za-wanghe on 2019/1/20.
//  Copyright © 2019 za-wanghe. All rights reserved.
//

import Foundation

class HistoryContentPresenterImpl<T: HistContentView>: HistContentPresenter {
    
    private var view: T
    private let respository: Respository
    
    private let PAGE_SIZE = 10
    private var pageNum = 1
    
    private var isLoading = false
    private var isLast = false
    
    init(view: T) {
        self.view = view
        self.respository = RespositoryManager.respository
        self.view.presenter = self as! T.T
        
    }
    
    func loadNextPage() {
        if (isLoading || isLast) {
            return
        }
        isLoading = true
        respository.getHistoryData(pageNum: pageNum, pageSize: PAGE_SIZE) {(response, rowResponse, error) -> Void in
            self.isLoading = false
            if (error == nil) {
                self.isLast = response?.results?.isEmpty ?? false
                self.view.addHistContentList(contents: response?.results)
                self.pageNum += 1
                
            }
        }
    }
    
    func start() {
        loadNextPage()
    }
    
    func destory() {
    }
    
    
}
