//
//  CategoryItemView.swift
//  gankio
//
//  Created by za-wanghe on 2019/1/12.
//  Copyright © 2019 za-wanghe. All rights reserved.
//

import UIKit

@IBDesignable class CategoryItemView: XibBirdgeView {
    
    static let MAX_HEIGHT: CGFloat = 50.0
    
    //MARK: properties
    @IBInspectable var content: String? {
        didSet {
            update()
        }
    }
    
    @IBInspectable var imageURL: String? {
        didSet {
            if (imageURL != oldValue) {
                updateImage()
            }
        }
    }
    
    @IBInspectable var authText: String? {
        didSet {
            update()
        }
    }
    
    @IBInspectable var pulishedAt: String? {
        didSet {
            update()
        }
    }
    
    private var isLoad = false
    
    //MARK: subviews
    @IBOutlet weak var contentView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authTextView: UILabel!
    @IBOutlet weak var publishedTimeLabel: UILabel!
    
    override init(frame: CGRect) {
        Log.i(item: "CategoryItemView init frame")
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        Log.i(item: "CategoryItemView init coder")
        super.init(coder: aDecoder)
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func prepareForInterfaceBuilder() {
        Log.i(item: "CategoryItemView prepareForInterfaceBuilder")
        super.prepareForInterfaceBuilder()
        initConstraint()
        update()
    }
    
    override func awakeFromNib() {
        Log.i(item: "CategoryItemView awakeFromNib")
        super.awakeFromNib()
        initConstraint()
        update()
    }
    
    private func initConstraint() {
        contentView.textContainerInset = .zero
        contentView.textContainer.lineFragmentPadding = 0
        let subView = subviews[0]
        topConstraint?.isActive = false
        bottomConstraint?.isActive = false
        leadingConstraint?.isActive = false
        trailingConstraint?.isActive = false
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        subView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        subView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        subView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
    }

    //MARK: Private Methods
    private func update() {
        if contentView == nil {
            return
        }
        contentView?.text = content
        authTextView?.text = authText
        publishedTimeLabel?.text = pulishedAt
        if (!isLoad) {
            updateImage()
        }
    }
    
    private func updateImage() {
        if (imageView == nil) {
            return
        }
        isLoad = true
        guard let url = imageURL else {
            imageView?.isHidden = true
            imageView?.image = nil
            return
        }
        imageView?.isHidden = false
        imageView?.loadImage(url: url)
    }
}
