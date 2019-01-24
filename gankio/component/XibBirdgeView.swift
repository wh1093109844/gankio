//
//  XibBirdgeView.swift
//  gankio
//
//  Created by za-wanghe on 2019/1/12.
//  Copyright © 2019 za-wanghe. All rights reserved.
//

import UIKit

class XibBirdgeView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var trailingConstraint: NSLayoutConstraint?
    var bottomConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Log.i(item: "XibBirdgeView init frame")
        loadXibView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Log.i(item: "XibBirdgeView init coder")
    }

    func getSelfClassName() -> String {
        let clazzType = type(of: self)
        var className = clazzType.description()
        if var index = className.lastIndex(of: ".") {
            index = className.index(after: index)
            className = String(className.suffix(from: index))
        }
        return className
    }
    
    func loadXibView() {
        Log.i(item: "XibBirdgeView loadXibView")
        let bundle = Bundle(for: type(of: self))
        let xibName = getSelfClassName()
        let xib = UINib(nibName: xibName, bundle: bundle)
        guard let result = xib.instantiate(withOwner: self, options: nil) as? [UIView] else {
            fatalError("load \(xibName).xib failed.")
        }
        
        let contentView = result[0]
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        constraints(contentView: contentView)
    }
    
    override func awakeFromNib() {
        Log.i(item: "XibBirdgeView awakeFromNib")
        super.awakeFromNib()
        loadXibView()
    }
    
    func constraints(contentView: UIView) {
        leadingConstraint = contentView.leadingAnchor.constraint(equalTo: leadingAnchor)
        leadingConstraint?.isActive = true
        trailingConstraint = contentView.trailingAnchor.constraint(equalTo: trailingAnchor)
        trailingConstraint?.isActive = true
        topConstraint = contentView.topAnchor.constraint(equalTo: topAnchor)
        topConstraint?.isActive = true
        bottomConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        bottomConstraint?.isActive = true
    }
}
