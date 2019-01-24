//
//  WebViewController.swift
//  gankio
//
//  Created by za-wanghe on 2019/1/24.
//  Copyright © 2019 za-wanghe. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webview: WKWebView!
    
    var url: String? {
        didSet {
            if (url == oldValue || url == nil) {
                return
            }
            loadUrl()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigation()
        webview.allowsBackForwardNavigationGestures = true
        webview.navigationDelegate = self
        loadUrl()
        // Do any additional setup after loading the view.
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("webview did start")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("webview didCommit")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("webview didFinish")
        webView.evaluateJavaScript("document.title") {(result, error) -> Void in
            if (result != nil) {
                guard let t = result as? String else {
                    fatalError()
                }
                print(t)
                self.title = t
            }
        }
    }
    
    private func loadUrl() {
        if url == nil {
            return
        }
        guard let uri = URL(string: url!) else {
            fatalError()
        }
        let request = URLRequest(url: uri)
        webview?.load(request)
    }
    
    private func initNavigation() {
        var leftBarButtonItem = UIBarButtonItem()
        leftBarButtonItem.image = UIImage(named: "icons_back")
        leftBarButtonItem.tintColor = UIColor.white
        navigationItem.setLeftBarButton(leftBarButtonItem, animated: true)
        leftBarButtonItem.target = self
        leftBarButtonItem.action = #selector(self.close)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    @objc func close() {
        let list = webview.backForwardList
        if list.backItem == nil {
            presentingViewController?.dismiss(animated: true, completion: nil)
        } else {
            webview.go(to: list.backItem!)
        }
    }

}
