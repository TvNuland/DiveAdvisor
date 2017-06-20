//
//  ViewController.swift
//  DiveAdvisor
//
//  Created by ben smith on 14/06/17.
//  Copyright © 2017 ben smith. All rights reserved.
//

import UIKit

struct notificationIDs {
    static let diveSearchByName = "diveSearchByName"
    static let diveSearchByGeo = "diveSearchByGeo"
    static let diveSearchByDetail = "diveSearchByDetail"
    
}

class ViewController: UIViewController {
    
    var matches: [Matches] = []
    var sites: [Sites] = []
    var detail: Site?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DAServiceClass.diveSearchByName("Shark's Cove")
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.diveSearchByNameObservers),
                                               name:  NSNotification.Name(rawValue: notificationIDs.diveSearchByName),
                                               object: nil)
        
        DAServiceClass.diveSearchByGeo(-8.348, 116.0563, 250)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.diveSearchByGeoObservers),
                                               name:  NSNotification.Name(rawValue: notificationIDs.diveSearchByGeo),
                                               object: nil)
        
        DAServiceClass.diveSearchByDetail(17559)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.diveSearchByDetailObservers),
                                               name:  NSNotification.Name(rawValue: notificationIDs.diveSearchByDetail),
                                               object: nil)
        
    }
    
    func diveSearchByNameObservers(notification: NSNotification) {
        var diveDict = notification.userInfo as! Dictionary<String, [Matches]>
        matches = diveDict["data"]!
    }
    
    
    func diveSearchByGeoObservers(notification: NSNotification) {
        var diveDict = notification.userInfo as! Dictionary<String, [Sites]>
        sites = diveDict["data"]!
    }
    
    func diveSearchByDetailObservers(notification: NSNotification) {
        var diveDict = notification.userInfo as! Dictionary<String, AnyObject>
        let urls = diveDict["urlData"]! as! [Urls]
        detail = diveDict["siteDetailData"]! as! Site
        detail?.urls = urls
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

