//
//  ViewExtends.swift
//  gankio
//
//  Created by za-wanghe on 2019/1/12.
//  Copyright © 2019 za-wanghe. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(url: URL) {
        do {
            guard let data: Data = try Data(contentsOf: url) else {
                fatalError("load data failed.")
            }
            let image = UIImage(data: data)
            self.image = image
        } catch {
            print("load image failed.")
        }
    }
    
    func loadImage(url: String) {
        guard let uri = URL(string: url) else {
            fatalError("url error")
        }
        loadImage(url: uri)
    }
}
