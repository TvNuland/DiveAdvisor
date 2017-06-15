//
//  URLCreator.swift
//  DiveAdvisor
//
//  Created by Achid Farooq on 15-06-17.
//  Copyright © 2017 ben smith. All rights reserved.
//

import Foundation
import Alamofire

enum SearchTerm {
    //http://api.divesites.com/?mode=search&str=shark
    case bySearchName(String)
    //http://api.divesites.com/?mode=sites&lat=-8.348&lng=116.0563&dist=250
    case bySearchByCoordDist(Double, Double, Int)
    //http://api.divesites.com/?mode=detail&siteid=17559
    case bySearchID(Int)
}

struct DAUrlCreator {
    private static let baseURLstring = "http://api.divesites.com/"
    private static let APImode = "?mode="
    
    private static func searchQuery(by term: SearchTerm) -> URLQueryItem? {
        switch term {
        case .bySearchName(let title):
            return URLQueryItem(name: "search&str", value: title)
        default:
            return nil
        }
    }


    private static func searchByCoordDist(by term: SearchTerm) -> URLQueryItem? {
        switch term {
        case .bySearchByCoordDist(let lat, let lng, let dist):
            return URLQueryItem(name: "sites&", value: lat, lng, dist)
        default:
            return nil
        }
    }
    
    private static func searchByID(by term: SearchTerm) -> URLQueryItem? {
        switch term {
        case .bySearchID(let ID):
            return URLQueryItem(name: "detail&detail", value: ID)
        default:
            return nil
        }
    }


    static func createDAURLWithComponents(term: SearchTerm, page: Int = 1) -> URL? {
        var urlcomps = URLComponents(string: DAUrlCreator.baseURLstring)!
        var queryItems = [URLQueryItem]()
        
        
        let baseParams = ["scheme" : "http",
                          "host" : "divesites.com",
                          "path" : "",
                          "apikey" : DAUrlCreator.APImode]
        for (key, value) in  baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }

        
        let searchQuery = DAUrlCreator.searchQuery(by: term)
        queryItems.append(searchQuery!)
        
        if let byLocation = DAUrlCreator.searchByCoordDist(by: term) {
            queryItems.append(byLocation)
        }
        
        
        urlcomps.queryItems = queryItems
                let test = urlcomps.queryItems
                print(test!)
        return urlcomps.url!
    }
    

}

