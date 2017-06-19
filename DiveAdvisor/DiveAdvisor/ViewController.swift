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

struct notificationDataKey {
    static let diveDataKey = "diveData"
}


class ViewController: UIViewController {
    
    var matches: [Matches] = []
    var sites: [Sites] = []
    var urls: [Urls] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        DAServiceClass.diveSearchByName("Shark Point")
        //        NotificationCenter.default.addObserver(self,
        //                                               selector: #selector(ViewController.diveSearchByNameObservers),
        //                                               name:  NSNotification.Name(rawValue: notificationIDs.diveSearchByName),
        //                                               object: nil)
        
//        DAServiceClass.diveSearchByGeo(-8.348, 116.0563, 250)
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(ViewController.diveSearchByGeoObservers),
//                                               name:  NSNotification.Name(rawValue: notificationIDs.diveSearchByGeo),
//                                               object: nil)
        
        DAServiceClass.diveSearchByDetail(18828)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.diveSearchByDetailObservers),
                                               name:  NSNotification.Name(rawValue: notificationIDs.diveSearchByDetail),
                                               object: nil)
        
        
    }
    
    func diveSearchByNameObservers(notification: NSNotification) {
        var diveDict = notification.userInfo as! Dictionary<String , [Matches]>
        matches = diveDict[notificationDataKey.diveDataKey]!
    }
    
    
    func diveSearchByGeoObservers(notification: NSNotification) {
        var diveDict = notification.userInfo as! Dictionary<String , [Sites]>
        sites = diveDict[notificationDataKey.diveDataKey]!
    }
    
    func diveSearchByDetailObservers(notification: NSNotification) {
        var diveDict = notification.userInfo as! Dictionary<String , [Urls]>
        urls = diveDict[notificationDataKey.diveDataKey]!
        print("Viewcontroller")
        for url in urls {
            print(url.name)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

