//
//  FirstViewController.swift
//  gankio
//
//  Created by za-wanghe on 2019/1/12.
//  Copyright © 2019 za-wanghe. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DaysView {
    
    private var dataSource: Response<[String: [Category]]>?
    private var dateFormatter: DateFormatter?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var historyButton: UIButton!
    
    var currentDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        dateFormatter = DateFormatter()
        dateFormatter?.dateFormat = "yyyy-MM-dd"
        initNavigationBar()
        DaysPresenterImpl<FirstViewController>(view: self, date: currentDate)
    }

    func handleResponse(response: Response<[String:[Category]]>?, rowResponse: URLResponse?, error: Error?) -> Void {
        print(response)
        dataSource = response
        var categoryList = response?.category ?? []
        let index = categoryList.firstIndex(of: "福利")
        if (index != nil) {
            categoryList.remove(at: index!)
            categoryList.insert("福利", at: 0)
        }
        dataSource?.category = categoryList
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func onCalenderClick(_ sender: UIBarButtonItem) {
        print("isHidden:\(scrollView.isHidden)")
        print("frame:\(scrollView.frame)")
        scrollView.isHidden = !scrollView.isHidden
    }
    //MARK: UITableviewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource?.category?.count ?? 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let type = dataSource?.category?[section] ?? ""
        let count = dataSource?.results?[type]?.count ?? 0
        Log.i(item: "tabview numberOfRowsInSection\t\(section)\ttype=\(type)\tcount=\(count)")
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        Log.i(item: "cellForRowAt\tindexPath = \(indexPath)")
        let type = dataSource!.category![indexPath.section]
        let category = dataSource!.results![type]![indexPath.row]
        var cell: UITableViewCell
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "image", for: indexPath)
            let imageView = cell.contentView.subviews[0] as! UIImageView
            if (category.url != nil) {
                imageView.loadImage(url: category.url!)
                
            }
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath)
            let categoryItemView = cell.contentView.subviews[0] as! CategoryItemView
            categoryItemView.content = category.desc
            categoryItemView.authText = category.who
            categoryItemView.imageURL = (category.images?.count ?? 0) >= 1 ? category.images?[0] : nil
            categoryItemView.pulishedAt = dateFormatter?.string(from: category.publishedAt!)
        }
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(self.showImageDetail))
        cell.addGestureRecognizer(tapGesture)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return dataSource?.category?[section]
//    }
//    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        let titleView = CategoryTitleView()
        titleView.title = dataSource?.category?[section]
        return titleView
    }
    
    //MARK: DaysView
    typealias T = DaysPresenterImpl
    
    var presenter: DaysPresenterImpl<FirstViewController>? {
        didSet {
            presenter?.start()
        }
    }
    
    func setDayData(data: Response<[String : [Category]]>?) {
        dataSource = data
        var categoryList = data?.category ?? []
        let index = categoryList.firstIndex(of: "福利")
        if (index != nil) {
            categoryList.remove(at: index!)
            categoryList.insert("福利", at: 0)
        }
        dataSource?.category = categoryList
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setHistory(history: [Date]?) {
        DispatchQueue.main.async {
            var totalWidth = CGFloat(0)
            var height = self.scrollView.contentSize.height
            guard let count = history?.count else {
                return
            }
            let length = min(7, count)
            var anchor = self.scrollContentView.leadingAnchor
            for i in 0..<length {
                let calendarItemView = CalendarItemView()
                self.scrollContentView.addSubview(calendarItemView)
                let size = calendarItemView.size();
                calendarItemView.date = history?[i]
                if (i == 0) {
                    calendarItemView.isSelect = true
                }
                calendarItemView.widthAnchor.constraint(equalToConstant: size.width).isActive = true
                calendarItemView.heightAnchor.constraint(equalToConstant: size.height).isActive = true
                calendarItemView.leadingAnchor.constraint(equalTo: anchor).isActive = true
                calendarItemView.topAnchor.constraint(equalTo: self.scrollContentView.topAnchor).isActive = true
                calendarItemView.bottomAnchor.constraint(equalTo: self.scrollContentView.bottomAnchor).isActive = true
                calendarItemView.frame = CGRect(x: totalWidth, y: 0, width: size.width, height: size.height)
                totalWidth += size.width
                height = size.height
                anchor = calendarItemView.trailingAnchor
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.loadData))
                calendarItemView.addGestureRecognizer(tapGestureRecognizer)
            }
            self.historyButton.leadingAnchor.constraint(equalTo: anchor).isActive = true
            self.scrollContentView.heightAnchor.constraint(equalToConstant: height).isActive = true
            self.scrollView.heightAnchor.constraint(equalToConstant: height).isActive = true
//            self.scrollView.frame = CGRect(origin: self.scrollView.frame.origin, size: CGSize(width: self.scrollView.frame.width, height: height))
            self.scrollView.layer.shadowColor = UIColor.red.cgColor
            self.scrollView.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.scrollView.layer.masksToBounds = false
            
        }
    }
    
    @objc func loadData(sender: UITapGestureRecognizer) {
        let item = sender.view as? CalendarItemView
        let date = item?.date ?? Date()
        print("\t(item.date)\t\(item?.days)\t\(item?.week)\t\(item?.month)")
        presenter?.loadDaysDataByDate(date: date)
        let subviews = sender.view?.superview?.subviews
        for view in subviews! {
            if view is CalendarItemView {
                (view as! CalendarItemView).isSelect = view == sender.view
            }
        }
    }
    
    @objc func showImageDetail(sender: UITapGestureRecognizer) {
        guard let cell = sender.view as? UITableViewCell else {
            fatalError("cell error")
        }
        guard let indexPath = tableView.indexPath(for: cell) else {
            fatalError()
        }
        guard let type = dataSource?.category?[indexPath.section] else {
            fatalError()
        }
        let category = dataSource?.results?[type]![indexPath.row]
        var vc: UIViewController
        if (indexPath.section == 0) {
            guard let imageViewController = storyboard?.instantiateViewController(withIdentifier: "imageController") as? ImageViewController else {
                fatalError("instance ImageViewController error!")
            }
            imageViewController.imageUrl = category?.url
            vc = imageViewController
        } else {
            guard let webviewController = storyboard?.instantiateViewController(withIdentifier: "webview_ controller") as? WebViewController else {
                fatalError()
            }
            webviewController.url = category?.url
            webviewController.title = category?.desc
            vc = webviewController
        }
        guard let navi = storyboard?.instantiateViewController(withIdentifier: "image_navigation") as? UINavigationController else {
            fatalError()
        }
        navi.setViewControllers([vc], animated: true)
        
        if tabBarController != nil {
            tabBarController?.present(navi, animated: true, completion: nil)
        } else {
            navigationController?.present(navi, animated: true, completion: nil)
        }
//        navigationController?.pushViewController(imageViewController, animated: true)
    }
    @IBAction func onHistoryListClick(_ sender: UIButton) {
    }
    
    private func initNavigationBar() {
        print("navigationItem.leftBarButtonItems = \(navigationItem.leftBarButtonItems)")
        print("navigationItem.leftBarButtonItem = \(navigationItem.leftBarButtonItem)")
        if currentDate != nil {
            var leftBarButtonItem = UIBarButtonItem()
            leftBarButtonItem.image = UIImage(named: "icons_back")
            leftBarButtonItem.tintColor = UIColor.white
            navigationItem.title = dateFormatter?.string(from: currentDate!)
            navigationItem.setLeftBarButton(leftBarButtonItem, animated: true)
            navigationItem.setRightBarButton(nil, animated: false)
            leftBarButtonItem.target = self
            leftBarButtonItem.action = #selector(self.close)
        }
        
    }
    
    @objc func close() {
        print("close")
        self.navigationController?.popViewController(animated: true)
//        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

