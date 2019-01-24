//
//  ImageViewController.swift
//  gankio
//
//  Created by za-wanghe on 2019/1/23.
//  Copyright © 2019 za-wanghe. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    private var imageView1: UIImageView?
    
    var imageUrl: String? {
        didSet {
            if imageUrl != nil && imageUrl != oldValue {
                imageView?.loadImage(url: imageUrl!)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ImageViewController viewDidLoad")
        let subview = view.viewWithTag(0)
        print("subview = \(subview)")
        print("content = \(contentView)")
        if subview is UIImageView {
            imageView1 = subview as? UIImageView
        }
        
        if imageUrl != nil {
            imageView?.loadImage(url: imageUrl!)
        }
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func close(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
