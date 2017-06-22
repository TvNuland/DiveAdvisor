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
        
        //let url = NSURL (string: "http://www.theperfectdive.com/DEF-Site.asp?sID=29");
        if let urlString = siteDetailObject?.weblink {
            //let url = urlString[0].url
            //print("Dit is url: \(url)")
            if let url = URL.init(string: urlString) {
                let request = NSURLRequest.init(url: url)
                webView.loadRequest(request as URLRequest);
            }
            
        }
        
        /*
         if let urlString = detailMovieObject?.poster {
         let url = URL(string: urlString)
         cell.fullImage.kf.setImage(with: url)
         }
         */
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
