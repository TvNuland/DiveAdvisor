//
//  CoreDataManagerTests.swift
//  DiveAdvisor
//
//  Created by Ton on 2017-06-20.
//  Copyright © 2017 ben smith. All rights reserved.
//

import Foundation
import CoreData

struct InterfaceDiveDetails {
    let id: Int16
    let image: NSObject?
    let normalTemperature: Double
    let review: String
    let waterTemperature: Double
    
    init(id: Int16, image: NSObject?, normalTemperature: Double, review: String, waterTemperature: Double) {
        self.id = id
        self.image = image
        self.normalTemperature = normalTemperature
        self.review = review
        self.waterTemperature = waterTemperature
    }
}

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
        storeDetails.append(InterfaceDiveDetails.init(id: 18828, image: nil, normalTemperature: 31, review: "review 18828", waterTemperature: 21))
        storeDetails.append(InterfaceDiveDetails(id: 18883, image: nil, normalTemperature: 32, review: "review 18883", waterTemperature: 22))
        storeDetails.append(InterfaceDiveDetails(id: 23255, image: nil, normalTemperature: 33, review: "review 23255", waterTemperature: 23))
        storeDetails.append(InterfaceDiveDetails(id: 12345, image: nil, normalTemperature: 34, review: "review 12345", waterTemperature: 24))
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
            for favorite in favorites {
                print("favorite:", favorite.id, favorite.review!)
            }
        }
    }
    
}
