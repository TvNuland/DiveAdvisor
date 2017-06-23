//
//  DivesiteMapAnnotation.swift
//  DiveAdvisor
//
//  Created by Paul Geurts on 20/06/2017.
//  Copyright © 2017 ben smith. All rights reserved.
//


import Foundation
import MapKit

class DivesiteMapAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var site: Sites
    
    init(site: Sites) {
        self.site = site
        self.title = site.name
        
        if let latString = site.lat,
            let longString = site.lng {
            
            let newlatString = latString.replacingOccurrences(of: ",",with: ".", options: .literal, range: nil)
            let newlongString = longString.replacingOccurrences(of: ",",with: ".", options: .literal, range: nil)
            
            let lat = Double(newlatString)
            let long = Double(newlongString)
            
            self.coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
            
        } else {
            
            self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
        
        
        super.init()
    }
    
}
