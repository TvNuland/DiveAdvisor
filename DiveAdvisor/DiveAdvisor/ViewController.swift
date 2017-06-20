//
//  ViewController.swift
//  DiveAdvisor
//
//  Created by ben smith on 14/06/17.
//  Copyright © 2017 ben smith. All rights reserved.
//

import UIKit
import MapKit

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}


class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var resultSearchController: UISearchController? = nil
    var selectedPin:MKPlacemark? = nil
    var currentWeatheronPin: Hourly?
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DAServiceClass.diveSearchByCoords()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: viewControllerIDs.locationSearchTable) as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.weatherReceivedNotificationObserver),
                                               name: NSNotification.Name(rawValue: "weatherReceivedNotification"),
                                               object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    func weatherReceivedNotificationObserver(notification: NSNotification) {
        var weatherDict: Dictionary<String, Hourly> = notification.userInfo as! Dictionary<String, Hourly>
        currentWeatheronPin = weatherDict["results"]!
        performSegue(withIdentifier: segueIDs.MapViewToDetailView, sender: self)

    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIDs.MapViewToDetailView {
    
            let detailView = segue.destination as! DetailTableViewController
            detailView.detailWeatherObject = currentWeatheronPin
        }
    }

}

extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }

    
    //Only do this when no search has been initialised yet
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print(location)
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }

}

extension ViewController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city), \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(1.05, 1.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
}

extension ViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let latitude = view.annotation?.coordinate.latitude
        let long = view.annotation?.coordinate.longitude
        let radius = 1.0
        weatherServiceClass.getWeatherByCoords(lat: latitude!, lng: long!, radius: radius)
//        weatherReceivedNotificationObserver()
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let pinToZoom = view.annotation
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: pinToZoom!.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        let pinToZoom = view.annotation
        let span = MKCoordinateSpanMake(1.05, 1.05)
        let region = MKCoordinateRegion(center: pinToZoom!.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        
        let identifier = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        pinView?.pinTintColor = UIColor.blue
        pinView?.canShowCallout = true
        pinView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView

        return pinView
    }
    
}

