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
    case bySearchCoordDist(Double, Double, Double)
    //http://api.divesites.com/?mode=detail&siteid=17559
    case bySearchID(Int)
}

struct DAUrlCreator {
    private static let baseURLstring = "http://api.divesites.com/"
//    private static let APImodeSearch = "?mode=search&s"
//    private static let APImodeSite = "?mode=site&s"
//    private static let APImodeDetail = "?mode=detail&s"

    private static func searchMode(by term: SearchTerm) -> URLQueryItem? {
        switch term {
        case .bySearchName:
            return URLQueryItem(name: "mode", value: "search")
        case .bySearchCoordDist:
            return URLQueryItem(name: "mode", value: "sites")
        case .bySearchID(let searchMode):
            return URLQueryItem(name: "mode", value: "detail")
        }
        
    }
    
    private static func searchQuery(by term: SearchTerm) -> URLQueryItem? {
        switch term {
        case .bySearchName(let title):
            return URLQueryItem(name: "str", value: title)
        default:
            return nil
        }
    }


    private static func searchByCoordDist(by term: SearchTerm) -> [URLQueryItem]? {
        switch term {
        case .bySearchCoordDist(let lat, let lng, let dist):
            var gpsQuery: [URLQueryItem] = []
            gpsQuery.append(URLQueryItem(name: "lat", value: String(lat)))
            gpsQuery.append(URLQueryItem(name: "lng", value: String(lng)))
            gpsQuery.append(URLQueryItem(name: "dist", value: String(dist)))
            return gpsQuery
        default:
            return nil
        }
    }
    
    private static func searchByID(by term: SearchTerm) -> URLQueryItem? {
        switch term {
        case .bySearchID(let ID):
            return URLQueryItem(name: "siteid", value: String(ID))
        default:
            return nil
        }
    }


    static func createDAURLWithComponents(term: SearchTerm, page: Int = 1) -> URL? {
        var urlcomps = URLComponents(string: DAUrlCreator.baseURLstring)!
        var queryItems = [URLQueryItem]()
        
        if  let searchModes = DAUrlCreator.searchMode(by: term) {
            queryItems.append(searchModes)
        }
        
        if let searchQuery = DAUrlCreator.searchQuery(by: term) {
            queryItems.append(searchQuery)
        }
        
        if let searchQuery = DAUrlCreator.searchByID(by: term) {
            queryItems.append(searchQuery)
        }
        
        if let searchByCoordDist = DAUrlCreator.searchByCoordDist(by: term) {
            for item in searchByCoordDist{
                queryItems.append(item)
            }
        }
        urlcomps.queryItems = queryItems
//        let test = urlcomps.queryItems
//        print(test!)
        return urlcomps.url!
    }
    

}

