//
//  MapviewExtension.swift
//  DiveAdvisor
//
//  Created by Paul Geurts on 22/06/2017.
//  Copyright © 2017 ben smith. All rights reserved.
//


import Foundation
import MapKit

extension MKMapView {
    
    func containsAnnotation(annotation: MKAnnotation) -> Bool {
        
        for existingAnnotation in self.annotations {
            let latExist = Double(existingAnnotation.coordinate.latitude).roundTo(places: 4)
            let longExist = Double(existingAnnotation.coordinate.longitude).roundTo(places: 4)
            if latExist == annotation.coordinate.latitude && longExist == annotation.coordinate.longitude{
                return true
            }
        }
        return false
        
    }
    
}

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
