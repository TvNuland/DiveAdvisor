//
//  Constants.swift
//  DiveAdvisor
//
//  Created by Paul Geurts on 15/06/2017.
//  Copyright © 2017 ben smith. All rights reserved.
//

import Foundation

struct viewControllerIDs {
    static let locationSearchTable = "LocationSearchTable"
}

struct cellIDs {
    static let searchResultCell = "SearchResultCell"
}

struct segueIDs {
    static let MapViewToDetailView = "MapToDetail"
}

struct notificationIDs {
    static let diveSearchByName = "diveSearchByName"
    static let diveSearchByGeo = "diveSearchByGeo"
    static let diveSearchByDetail = "diveSearchByDetail"
    static let passWeatherDetails = "weatherReceivedNotification"
}
