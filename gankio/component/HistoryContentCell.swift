//
//  HistoryContentCell.swift
//  gankio
//
//  Created by za-wanghe on 2019/1/20.
//  Copyright © 2019 za-wanghe. All rights reserved.
//

import UIKit

class HistoryContentCell: XibBirdgeView {
    
    var imageUrl: String? {
        didSet {
            if (imageUrl != nil && imageUrl != oldValue) {
                imageView?.loadImage(url: imageUrl!)
            }
        }
    }
    
    var dateText: String? {
        didSet {
            update()
        }
    }
    
    var title: String? {
        didSet {
            update()
        }
    }
    
    //MARK: Views
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateTextView: UILabel!
    @IBOutlet weak var titleTextView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if imageUrl != nil{
            imageView.loadImage(url: imageUrl!)
        }
        update()
    }
    
//    override func constraints(contentView: UIView) {
//        contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
//        contentView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
//        contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
//        contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5).isActive = true
//    }
    
    private func update() {
        dateTextView?.text = dateText
        titleTextView?.text = title
        print(imageView?.frame)
    }

}
