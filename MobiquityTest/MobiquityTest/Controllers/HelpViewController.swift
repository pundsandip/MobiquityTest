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
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    private func loadData() {
        guard let url = URL(string: "https://openweather.co.uk/storage/app/media/Terms/Openweather_website_terms_and_conditions_of_use.pdf") else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }

}
