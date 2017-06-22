//
//  CoreDataManagerTests.swift
//  DiveAdvisor
//
//  Created by Ton on 2017-06-20.
//  Copyright © 2017 ben smith. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManagerTests {
    
    private static var loadDetails: [InterfaceDiveDetails] = []
    private static var storeDetails: [InterfaceDiveDetails] = []
    
    static func testCoreDataClear() {
        CoreDataManager.sharedInstance.loadFavoriteDiveDetails {
            (favorites) -> Void in
            for favorite in favorites {
                CoreDataManagerTests.testCoreDataDelete(id: Int(favorite.id))
            }
            print("inititally loaded and deleted", favorites.count, "favorites")
        }
    }
    
    static func testCoreDataInit() {
//  must add missing attributes
        storeDetails.append(InterfaceDiveDetails.init(id: 18828, name: "test 18828", country: "Netherlands", ocean: "Noordzee", imageURL: "https://www.someimage.com", review: "review of 18828", latitude: 123.10, longitude: 321.10))
        storeDetails.append(InterfaceDiveDetails.init(id: 12345, name: "test 12345", country: "Belgium", ocean: "Noordzee", imageURL: "https://www.someimage.com", review: "review of 12345", latitude: 456.10, longitude: 654.10))
        storeDetails.append(InterfaceDiveDetails.init(id: 19876, name: "test 19876", country: "Germany", ocean: "Noordzee", imageURL: "https://www.someimage.com", review: "review of 19876", latitude: 789.10, longitude: 987.10))
        storeDetails.append(InterfaceDiveDetails.init(id: 15000, name: "test 15000", country: "France", ocean: "Noordzee", imageURL: "https://www.someimage.com", review: "review of 15000", latitude: 0.10, longitude: 0.10))
  }
    
    static func testCoreDataStore() {
        for detail in storeDetails {
            do {
                try CoreDataManager.sharedInstance.storeDiveDetails(for: detail)
                print("stored:", detail)
            } catch {
                print("storeDiveDetails error")
            }
        }
    }
    
    static func testCoreDataDelete(id: Int) {
        do {
            try CoreDataManager.sharedInstance.deleteDiveDetails(for: id)
        } catch {
            print("deleteDiveDetails error")
        }
    }
    
    static func testCoreDataLoad() {
        for detail in storeDetails {
            let result = CoreDataManager.sharedInstance.loadDiveDetails(for: Int(detail.id))
            switch result {
            case .success(let loadDetail):
                print("loaded:", loadDetail.id, loadDetail.review!)
            case .notFound:
                print("not loaded:", detail.id)
            }
        }
    }
    
    static func testCoreDataLoadFavorites() {
        CoreDataManager.sharedInstance.loadFavoriteDiveDetails {
            (favorites) -> Void in
            print("loaded", favorites.count, "favorites")
            for fav in favorites {
                print("favorite:", fav.id, fav.name, fav.country, fav.ocean)
            }
        }
    }
    
}
