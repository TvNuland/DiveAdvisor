//
//  DiveAdvisorService.swift
//  DiveAdvisor
//
//  Created by Achid Farooq on 14-06-17.
//  Copyright © 2017 ben smith. All rights reserved.
//

import Foundation
import Alamofire

typealias DAapiName = (Bool, [AnyObject]?, NSError?) -> Void

enum MatchOn: String {
    case matches
    case sites
    case detail = "urls"
}

class DAServiceClass {
    
    static func diveSearchByName(_ name: String)  {
        let url = DAUrlCreator.createDAURLWithComponents(term: .bySearchName(name))
        alamoFireCall(url: url!, matchOn: .matches) {
            (result, matches, aNSerror) -> Void in
            if result == false {
                print(aNSerror)
            } else {
                let diveDict = [notificationDataKey.diveDataKey: matches]
                NotificationCenter.default.post(name: Notification.Name(rawValue: notificationIDs.diveSearchByName),
                                                object: self, userInfo: diveDict)
            }
        }
    }
    
    static func diveSearchByGeo(_ lat: Double, _ lng: Double, _ dist: Int)  {
        let url = DAUrlCreator.createDAURLWithComponents(term: .bySearchCoordDist(lat, lng, dist))
        alamoFireCall(url: url!, matchOn: .sites) {
            (result, sites, aNSerror) -> Void in
            if result == false {
                print(aNSerror)
            } else {
                let diveDict = [notificationDataKey.diveDataKey: sites]
                NotificationCenter.default.post(name: Notification.Name(rawValue: notificationIDs.diveSearchByGeo),
                                                object: self, userInfo: diveDict)
            }
        }
    }
    
    static func diveSearchByDetail(_ id: Int)  {
        let url = DAUrlCreator.createDAURLWithComponents(term: .bySearchID(id))
        print(url!)
        alamoFireCall(url: url!, matchOn: .detail) {
            (result, urls, aNSerror) -> Void in
            if result == false {
                print(aNSerror)
            } else {
                let diveDict = [notificationDataKey.diveDataKey: urls]
                NotificationCenter.default.post(name: Notification.Name(rawValue: notificationIDs.diveSearchByGeo),
                                                object: self, userInfo: diveDict)
            }
        }
    }
    
    private static func alamoFireCall(url: URL, matchOn: MatchOn, _ onCompletion: @escaping DAapiName) {
        Alamofire.request(url).responseJSON { response in
            if let error = response.result.error {
                print(error)
            }
            if let value = response.result.value as? NSDictionary {
                //                print(value["result"])
                parseReceivedData(value, matchOn: matchOn, onCompletion)
                print("alamoFireCall", matchOn)
            } else {
                let error = NSError.init(domain: "Alamofire response Error", code: -101)
                onCompletion(false, nil, error)
            }
        }
    }
    
    
    //    static func diveSearchByCoords() {
    //        let url = DAUrlCreator.createDAURLWithComponents(term: .bySearchByCoordDist(-8.348, 116.0563, 250))
    //        print(url!)
    //        Alamofire.request(url!).responseJSON { response in
    //            if let error = response.result.error {
    //                print(error)
    //            }
    //            if let value = response.result.value {
    //                print(value)
    //            }
    //        }
    //    }
    
    
    //    static func diveSearchByName() {
    //        let url = DAUrlCreator.createDAURLWithComponents(term: .bySearchName("Kleine Knip"))
    //        print(url!)
    //        Alamofire.request(url!).responseJSON { response in
    //            if let error = response.result.error {
    //                print(error)
    //            }
    //            if let value = response.result.value as? NSDictionary {
    //                //                print(value["result"])
    //                parseReceivedData(value, matchOn: "matches") {
    //                    (result, matches, aNSerror) -> Void in
    //                    if result == false {
    //                        print(aNSerror)
    //                    } else {
    //                        for match in matches! {
    //                            print(match.id, match.name, match.distance, match.lat, match.lng)
    //                        }
    //                    }
    //                }
    //            } else {
    //                let error = NSError.init(domain: "Alamofire response Error", code: -101)
    //                print(error)
    //            }
    //        }
    //    }
    
    
    //    static func diveSearchByDetail() {
    //        let url = DAUrlCreator.createDAURLWithComponents(term: .bySearchID(17559))
    //        print(url!)
    //        Alamofire.request(url!).responseJSON { response in
    //            if let error = response.result.error {
    //                print(error)
    //            }
    //            if let value = response.result.value {
    //                print(value)
    //            }
    //        }
    //    }
    
    private static func parseReceivedData(_ jsonDict: NSDictionary, matchOn: MatchOn, _ onCompletion:  DAapiName) {
        
        //getting the value of "response" -> which should be false
        if let responseResult = jsonDict["result"] as? Bool {
            if responseResult == false {
                let error = NSError.init(domain: "DA Error", code: -100, userInfo: [NSLocalizedDescriptionKey : jsonDict["message"]])
                onCompletion(false, nil, error)
            } else {
                if let responseArray = jsonDict[matchOn.rawValue] as? NSArray {
                    //                    print(responseMatches)
                    print("parseRecData", responseArray)
                    switch matchOn {
                    case .matches:
                        iterateArrayOfMatches(searchResults: responseArray, onCompletion)
                    case .sites:
                        iterateArrayOfSites(searchResults: responseArray, onCompletion)
                    case .detail:
                        iterateArrayOfUrls(searchResults: responseArray, onCompletion)
                    }
                } else {
                    let error = NSError.init(domain: "JSON Parse Error", code: -101)
                    onCompletion(false, nil, error)
                }
            }
        }
    }
    
    private static func iterateArrayOfMatches(searchResults: NSArray, _ onCompletion:  DAapiName) {
        var temp: [Matches] = []
        for searchResult in searchResults {
            if let searchResult = searchResult as? [String: AnyObject] {
                //parse and store json response
                let item = Matches.init(dictionary: searchResult as NSDictionary)
                temp.append(item!)
            } else {
                let error = NSError.init(domain: "Parse Error Matches", code: -101)
                onCompletion(false, nil, error)
            }
        }
        onCompletion(true, temp, nil)
    }
    
    private static func iterateArrayOfSites(searchResults: NSArray, _ onCompletion:  DAapiName) {
        var temp: [Sites] = []
        for searchResult in searchResults {
            if let searchResult = searchResult as? [String: AnyObject] {
                //parse and store json response
                let item = Sites.init(dictionary: searchResult as NSDictionary)
                temp.append(item!)
            } else {
                let error = NSError.init(domain: "Parse Error Sites", code: -101)
                onCompletion(false, nil, error)
            }
        }
        onCompletion(true, temp, nil)
    }
    
    private static func iterateArrayOfUrls(searchResults: NSArray, _ onCompletion:  DAapiName) {
        var temp: [Urls] = []
        for searchResult in searchResults {
            if let searchResult = searchResult as? [String: AnyObject] {
                //parse and store json response
                let item = Urls.init(dictionary: searchResult as NSDictionary)
                temp.append(item!)
            } else {
                let error = NSError.init(domain: "Parse Error Urls", code: -101)
                onCompletion(false, nil, error)
            }
        }
        onCompletion(true, temp, nil)
    }
    
}


