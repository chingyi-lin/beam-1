//
//  UpdateWebViewController.swift
//  pass-share
//
//  Created by CY on 2019/4/30.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit
import WebKit

class UpdateWebViewController: UIViewController, WKNavigationDelegate {
    
    var domain: String?
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        
        var urlString = ""
        switch domain! {
        case "instagram.com":
            urlString = "https://www.instagram.com/accounts/password/change/"
        default:
            urlString = "https://" + domain!
        }
        
        let url = URL(string: urlString)!
        
        webView.load(URLRequest(url: url))
        
        // Adding refresh button
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}
