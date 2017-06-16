//
//  DiveAdvisorService.swift
//  DiveAdvisor
//
//  Created by Achid Farooq on 14-06-17.
//  Copyright © 2017 ben smith. All rights reserved.
//

import Foundation
import Alamofire

typealias DAapiName = (Bool, [Matches]?, NSError?) -> Void


class DAServiceClass {
    
    static func diveSearchByName(_ name: String)  {
        let url = DAUrlCreator.createDAURLWithComponents(term: .bySearchName(name))
        print(url!)
        var matches: [Matches] = []
        alamoFireCall(url: url!, matchOn: "matches") {
            (result, matches, aNSerror) -> Void in
            if result == false {
                print(aNSerror)
            } else {
                for match in matches! {
                    print(match.id)
//                    ---- notify -----
                }
            }
        }
    }
    
    private static func alamoFireCall(url: URL, matchOn: String, _ onCompletion: @escaping DAapiName) {
        Alamofire.request(url).responseJSON { response in
            if let error = response.result.error {
                print(error)
            }
            if let value = response.result.value as? NSDictionary {
                //                print(value["result"])
                parseReceivedData(value, matchOn: matchOn, onCompletion)
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
    
    private static func parseReceivedData(_ jsonDict: NSDictionary, matchOn: String, _ onCompletion:  DAapiName) {
        
        //getting the value of "response" -> which should be false
        if let responseResult = jsonDict["result"] as? Bool {
            if responseResult == false {
                let error = NSError.init(domain: "DA Error", code: -100, userInfo: [NSLocalizedDescriptionKey : jsonDict["message"]])
                onCompletion(false, nil, error)
            } else {
                if let responseMatches = jsonDict[matchOn] as? NSArray {
                    //                    print(responseMatches)
                    iterateArrayOf(searchResults: responseMatches, onCompletion)
                }
            }
        }
        
    }
    private static func iterateArrayOf(searchResults: NSArray, _ onCompletion:  DAapiName) {
        var temp: [Matches] = []
        for searchResult in searchResults{
            if let searchResult = searchResult as? [String: AnyObject] {
                //parse and store json response
                let match = Matches.init(dictionary: searchResult as NSDictionary)
                temp.append(match!)
                onCompletion(true, temp, nil)
            } else {
                let error = NSError.init(domain: "Parse Error", code: -101)
                onCompletion(false, nil, error)
                
            }
        }
        
    }
    
}


