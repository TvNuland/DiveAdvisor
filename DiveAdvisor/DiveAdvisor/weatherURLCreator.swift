//
//  weatherURLCreator.swift
//  DiveAdvisor
//
//  Created by Paul Geurts on 16/06/2017.
//  Copyright © 2017 ben smith. All rights reserved.
//

import Foundation
import Alamofire

struct weatherURLCreator {
    private static let baseURLString = "http://api.worldweatheronline.com/premium/v1/marine.ashx"
    private static let apiKey = "d187a8d7ea734fcb9c2102045171406"

    static func createWeatherURL(lat: Double, lng: Double, radius: Double) -> URL? {
        var components = URLComponents(string: baseURLString)!
        var queryItems = [URLQueryItem]()
        
        let baseParams = [
            "key": weatherURLCreator.apiKey
        ]
        
        for (key, value) in baseParams {
            
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
       
        //value should be (lat+,+long) , not hard coded *********************
        let searchOnCoordinates = URLQueryItem(name: "q", value: "\(lat),\(lng)")
        queryItems.append(searchOnCoordinates)
        
        let outputAsJSONFormat = URLQueryItem(name: "format", value: "json")
        queryItems.append(outputAsJSONFormat)
        
        let outputPerDay = URLQueryItem(name: "tp", value: "24")
        queryItems.append(outputPerDay)
        
        components.queryItems = queryItems
        return components.url!
    }


}



