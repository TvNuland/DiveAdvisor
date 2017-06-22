//
//  Code-snippet-LongPress.swift
//  DiveAdvisor
//
//  Created by Paul Geurts on 21/06/2017.
//  Copyright © 2017 ben smith. All rights reserved.
//

import Foundation


@IBAction func longPressDropPin(_ recognizer: UIGestureRecognizer) {
    if recognizer.state == UIGestureRecognizerState.began {
        dropPinOnLongTap(gestureRecognizer: recognizer)
        
    }
}

func dropPinOnLongTap(gestureRecognizer:UIGestureRecognizer){
    mapView.removeAnnotations(mapView.annotations)
    let touchPoint = gestureRecognizer.location(in: mapView)
    let newCoordinates = mapView.convert(touchPoint, toCoordinateFrom: mapView)
    let annotation = MKPointAnnotation()
    annotation.title = "Dropped Pin"
    annotation.coordinate = newCoordinates
    mapView.addAnnotation(annotation)
    
    DAServiceClass.diveSearchByGeo(lat: annotation.coordinate.latitude, lng: annotation.coordinate.longitude, dist: Int(radius/100))
}

//      --Example when not written out as a seperate function:
//      @IBAction func longPressDropPin(_ recognizer: UIGestureRecognizer) {
//        if recognizer.state == UIGestureRecognizerState.began {
//            let touchPoint = recognizer.location(in: mapView)
//            let newCoordinates = mapView.convert(touchPoint, toCoordinateFrom: mapView)
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = newCoordinates
//            mapView.addAnnotation(annotation)
//
//        }
//    }
