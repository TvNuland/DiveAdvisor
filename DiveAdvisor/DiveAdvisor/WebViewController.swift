//
//  WebViewController.swift
//  DiveAdvisor
//
//  Created by Paul Geurts on 22/06/2017.
//  Copyright © 2017 ben smith. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    var siteDetailObject: SiteDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let urlString = siteDetailObject?.weblink {
            if let url = URL.init(string: urlString) {
                let request = NSURLRequest.init(url: url)
                webView.loadRequest(request as URLRequest);
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
