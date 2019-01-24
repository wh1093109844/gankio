//
//  SecondViewController.swift
//  gankio
//
//  Created by za-wanghe on 2019/1/12.
//  Copyright © 2019 za-wanghe. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    private let titles = ["全部", "Android", "iOS", "休息视频", "拓展资源", "前端", "福利", "全部", "Android", "iOS", "休息视频", "拓展资源", "前端", "福利"]
    @IBOutlet weak var tabbar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var tabbarItems: [UITabBarItem] = []
        for item in titles {
            let tabbarItem = UITabBarItem()
            tabbarItem.title = item
            tabbarItems.append(tabbarItem)
        }
        tabbar.setItems(tabbarItems, animated: true)
    }


}

