//
//  WebViewController.swift
//  SoMaHomework
//
//  Created by Truth on 2017. 10. 29..
//  Copyright © 2017년 k1mtruth. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    // MARK:- Properties
    @IBOutlet weak var webView: WKWebView!
    var nation: String!
    
    
    // MARK: - Methods
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.navigationDelegate = self
        searchGoogle(query: nation)
    }
    
    // MARK: Custom Methods
    func searchGoogle(query: String) {
        let urlString = "https://www.google.com/search?q=" + query
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        self.webView.load(urlRequest)
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.webView.goBack()
    }
    
    @IBAction func stopButtonDidTap(_ sender: Any) {
        self.webView.stopLoading()
    }
    
    @IBAction func refreshButtonDidTap(_ sender: Any) {
        self.webView.reload()
    }
    
    @IBAction func forwardButtonDidTap(_ sender: Any) {
        self.webView.goForward()
    }
    
    @IBAction func closeButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

// Mark: - WKNavigationDelegate

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
