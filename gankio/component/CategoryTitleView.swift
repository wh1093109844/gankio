//
//  CategoryTitleView.swift
//  gankio
//
//  Created by za-wanghe on 2019/1/15.
//  Copyright © 2019 za-wanghe. All rights reserved.
//

import UIKit

@IBDesignable class CategoryTitleView: XibBirdgeView {
    
    @IBInspectable var title: String? {
        didSet {
            updateTitle()
        }
    }
    
    //MARK: Views
    
    @IBOutlet weak var titleView: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateTitle()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateTitle()
    }
    
    private func updateTitle() {
        titleView?.text = title
    }
}
