//
//  HelpViewController.swift
//  MobiquityTest
//
//  Created by Sandip Pund on 11/12/20.
//  Copyright © 2020 Sandip Pund. All rights reserved.
//

import UIKit
import WebKit

class HelpViewController: UIViewController {
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView(frame: self.view.bounds)
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    private func loadData() {
        let urlString = "https://openweather.co.uk/storage/app/media/Terms/Openweather_website_terms_and_conditions_of_use.pdf"
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }

}

extension HelpViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finished loading")
    }
}
