//
//  DiveAdvisorService.swift
//  DiveAdvisor
//
//  Created by Achid Farooq on 14-06-17.
//  Copyright © 2017 ben smith. All rights reserved.
//

import Foundation
import Alamofire
import MapKit

typealias DAapiName = (Bool, [String: AnyObject]?, NSError?) -> Void

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
                NotificationCenter.default.post(name: Notification.Name(rawValue: notificationIDs.diveSearchByName),
                                                object: self, userInfo: matches)
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
                NotificationCenter.default.post(name: Notification.Name(rawValue: notificationIDs.diveSearchByGeo),
                                                object: self, userInfo: sites)
            }
        }
    }
    
    static func diveSearchByDetail(_ id: Int)  {
        let url = DAUrlCreator.createDAURLWithComponents(term: .bySearchID(id))
        alamoFireCall(url: url!, matchOn: .detail) {
            (result, detail, aNSerror) -> Void in
            if result == false {
                print(aNSerror)
            } else {
                NotificationCenter.default.post(name: Notification.Name(rawValue: notificationIDs.diveSearchByDetail),
                                                object: self, userInfo: detail)
            }
        }
    }
    
    
    
    private static func alamoFireCall(url: URL, matchOn: MatchOn, _ onCompletion: @escaping DAapiName) {
        Alamofire.request(url).responseJSON { response in
            if let error = response.result.error {
                print(error)
            }
            if let value = response.result.value as? NSDictionary {
                parseReceivedData(value, matchOn: matchOn, onCompletion)
            } else {
                let error = NSError.init(domain: "Alamofire response Error", code: -101)
                onCompletion(false, nil, error)
            }
        }
    }
    
    private static func parseReceivedData(_ jsonDict: NSDictionary, matchOn: MatchOn, _ onCompletion:  DAapiName) {
        if let responseResult = jsonDict["result"] as? Bool {
            if responseResult == false {
                let error = NSError.init(domain: "DA Error", code: -100, userInfo: [NSLocalizedDescriptionKey : jsonDict["message"]])
                onCompletion(false, nil, error)
            } else {
                if let responseArray = jsonDict[matchOn.rawValue] as? NSArray {
                    switch matchOn {
                    case .matches:
                        iterateArrayOfMatches(searchResults: responseArray, onCompletion)
                    case .sites:
                        iterateArrayOfSites(searchResults: responseArray, onCompletion)
                    case .detail:
                        if let sitesDict = jsonDict["site"] as? NSDictionary {
                            let siteDetail = Site.init(dictionary: sitesDict)
                            iterateArrayOfUrls(searchResults: responseArray, siteDetail!, onCompletion)
                        }
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
                let item = Matches.init(dictionary: searchResult as NSDictionary)
                //check for presence in core data before doing this expensive ooperation!
                let diveID = searchResult["id"] as! Int
                let result = CoreDataManager.sharedInstance.loadDiveDetails(for: diveID)
                switch result {
                case .success(let detailCD):
                    item?.country = detailCD.country
                    item?.ocean = detailCD.ocean
                    temp.append(item!)
                case .notFound:
                    reverseGeoLocationcoords(item!)
                }
            } else {
                let error = NSError.init(domain: "Parse Error Matches", code: -101)
                onCompletion(false, nil, error)
            }
        }
        onCompletion(true, ["data": temp as AnyObject], nil)
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
        onCompletion(true, ["data": temp as AnyObject], nil)
    }
    
    private static func iterateArrayOfUrls(searchResults: NSArray, _ detailSite: Site, _ onCompletion:  DAapiName) {
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
        onCompletion(true, ["urlData" : temp as AnyObject , "siteDetailData" : detailSite], nil)
    }
    
    //  MARK: MapKit Geo Locator
    private static func reverseGeoLocationcoords(_ diveSite: Matches) {
        if let placemark = diveSite.mapItem?.placemark{
            
            let location = CLLocation(latitude: placemark.coordinate.latitude,
                                      longitude: placemark.coordinate.longitude) //changed!!!
            print(location)
            
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: {
                (placemarks, error) -> Void in
                print(location)
                
                if error != nil {
                    print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                    return
                }
                
                if (placemarks?.count)! > 0 {
                    let pm = placemarks?[0]
                    if let mapItem = diveSite.mapItem {
                        if let country = pm?.country {
                            diveSite.country = country
                            mapItem.name?.append(": \(country)")
                        }
                        if let ocean = pm?.ocean {
                            diveSite.ocean = ocean
                            mapItem.name?.append(", \(ocean)")
                        }
                        storeDiveDetailsfromGeo(for: diveSite)
                        
                        OperationQueue.main.addOperation {
                            NotificationCenter.default.post(name: Notification.Name(rawValue: "notifyUpdateRow"),
                                                            object: self,
                                                            userInfo: ["mapitem":diveSite.mapItem])
                        }
                    }
                }
                else {
                    print("Problem with the data received from geocoder")
                }
            })
        }
    }
    
    //  MARK: Store CoreData entity DiveDetails for a DiveSite including reverse Geocoder information
    private static func storeDiveDetailsfromGeo(for diveSite: Matches) {
        do {
            guard let id = diveSite.id,
                let idCD = Int16(id)
                else {
                    fatalError("storeDiveDetailsFromGeo error for divesiteID")
            }
            guard let latitude = diveSite.lat,
                let latitudeCD = Double(latitude),
                let longitude = diveSite.lng,
                let longitudeCD = Double(longitude)
                else {
                    fatalError("storeDiveDetailsFromGeo error for coordinates")
            }
            let nameCD = diveSite.name ?? ""
            let countryCD = diveSite.country ?? ""
            let oceanCD = diveSite.ocean ?? ""
            //   these attributes do not exist in the DiveSite or in Geocoder, so cannot be stored right now
            //   detailCD?.imageURL = diveSite.imageURL
            //   detailCD?.review = diveSite.review
            let detailCD = InterfaceDiveDetails(id: idCD, name: nameCD, country: countryCD, ocean: oceanCD, imageURL: "", review: "", latitude: latitudeCD, longitude: longitudeCD)
            try CoreDataManager.sharedInstance.storeDiveDetails(for: detailCD)
        } catch {
            fatalError("storeDiveDetailsFromGeo error for \(diveSite.id!)")
        }
    }
    
}
