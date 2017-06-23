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

enum searchRadius: Double{
    case s = 5.0
    case m = 10.0
    case l = 20.0
    case xl = 100.0
    
    var name: String {
    get { return String(describing: self)}
    }
}

class ViewController: UIViewController {
    
    var sites: [Sites] = []
    var detail: SiteDetail?
    var radiusNauticalMiles = searchRadius.s.rawValue
    let metresInNauticalMiles = 1852.0
    var radiusMetres: Double {
        get {
            return radiusNauticalMiles * metresInNauticalMiles
        }
    }
    
    let locationManager = CLLocationManager()
    var resultSearchController: UISearchController? = nil
    var selectedPin:MKPlacemark? = nil
    var currentWeatheronPin: Hourly?
    var currentLocation: CLLocationCoordinate2D?
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var segmentControl: ADVSegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //        DAServiceClass.diveSearchByGeo(-8.348, 116.0563, 250)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.diveSearchByGeoObservers),
                                               name:  NSNotification.Name(rawValue: notificationIDs.diveSearchByGeo),
                                               object: nil)
        
        //        DAServiceClass.diveSearchByDetail(17559)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.diveSearchByDetailObservers),
                                               name:  NSNotification.Name(rawValue: notificationIDs.diveSearchByDetail),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.weatherReceivedNotificationObserver),
                                               name: NSNotification.Name(rawValue: notificationIDs.passWeatherDetails),
                                               object: nil)
        
        //Setup location manager
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestLocation()
        mapView.showsUserLocation = true
        
        //Setup search table
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: viewControllerIDs.locationSearchTable) as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        locationSearchTable.handleMapSearchDelegate = self
        
        //Setup search bar
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        
        //Setup segment controls
        segmentControl.items = ["\(searchRadius.s.name)", "\(searchRadius.m.name)", "\(searchRadius.l.name)", "\(searchRadius.xl.name)"]
        segmentControl.font = UIFont(name: "Avenir-Black", size: 12)
        segmentControl.borderColor = UIColor(white: 1.0, alpha: 0.3)
        segmentControl.selectedIndex = 0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        detail = nil
        currentWeatheronPin = nil
    }
    
    
    @IBAction func selectRadiusSegment(_ sender: Any) {
        
        if segmentControl.selectedIndex == 0 {
            
            if let coord = currentLocation {
                //self.mapView.removeAnnotations(self.mapView.annotations)
                let location = CLLocation.init(latitude: coord.latitude, longitude: coord.longitude)
                radiusNauticalMiles = searchRadius.s.rawValue
                DAServiceClass.diveSearchByGeo(lat: location.coordinate.latitude, lng: location.coordinate.longitude, dist: radiusNauticalMiles)
                addRadiusCircle(location: location, withRadiusInMetres: radiusMetres)
            }
            
        } else if segmentControl.selectedIndex == 1 {
            if let coord = currentLocation {
                radiusNauticalMiles = searchRadius.m.rawValue
                let radius = searchRadius.m.rawValue
                //self.mapView.removeAnnotations(self.mapView.annotations)
                let location = CLLocation.init(latitude: coord.latitude, longitude: coord.longitude)
                DAServiceClass.diveSearchByGeo(lat: location.coordinate.latitude, lng: location.coordinate.longitude, dist: radiusNauticalMiles)
                addRadiusCircle(location: location, withRadiusInMetres: radiusMetres)
            }
            
        } else if segmentControl.selectedIndex == 2 {
            if let coord = currentLocation {
                radiusNauticalMiles = searchRadius.l.rawValue

                //self.mapView.removeAnnotations(self.mapView.annotations)
                let location = CLLocation.init(latitude: coord.latitude, longitude: coord.longitude)
                DAServiceClass.diveSearchByGeo(lat: location.coordinate.latitude, lng: location.coordinate.longitude, dist: radiusNauticalMiles)
                addRadiusCircle(location: location, withRadiusInMetres: radiusMetres)
            }
        }
            
        else {
            if let coord = currentLocation {
                radiusNauticalMiles = searchRadius.xl.rawValue

                //self.mapView.removeAnnotations(self.mapView.annotations)
                let location = CLLocation.init(latitude: coord.latitude, longitude: coord.longitude)
                DAServiceClass.diveSearchByGeo(lat: location.coordinate.latitude, lng: location.coordinate.longitude, dist: radiusNauticalMiles)
                addRadiusCircle(location: location, withRadiusInMetres: radiusMetres)
            }
        }
    }
    
    func diveSearchByGeoObservers(notification: NSNotification) {
        
        
        var diveDict = notification.userInfo as! Dictionary<String, [Sites]>
        sites = diveDict["data"]!
        
//        self.mapView.removeAnnotations(self.mapView.annotations)
        
        for site in sites {
            
            let annotation = DivesiteMapAnnotation.init(site: site)
            if self.mapView.containsAnnotation(annotation: annotation) == false {
                mapView.addAnnotation(annotation)
            }
        }
        
    }
    
    func diveSearchByDetailObservers(notification: NSNotification) {
        var diveDict = notification.userInfo as! Dictionary<String, AnyObject>
        let urls = diveDict["urlData"]! as! [Urls]
        
        detail = diveDict["siteDetailData"]! as! SiteDetail
        detail?.urls = urls
        print(detail?.urls?[0].url)
        detail?.weblink = detail?.urls?[0].url
        if shouldPerformSegue(withIdentifier: segueIDs.MapViewToDetailView, sender: self) {
            performSegue(withIdentifier: segueIDs.MapViewToDetailView, sender: self)
        }
        // parse the website
    }
    
    func weatherReceivedNotificationObserver(notification: NSNotification) {
        var weatherDict: Dictionary<String, Hourly> = notification.userInfo as! Dictionary<String, Hourly>
        
        currentWeatheronPin = weatherDict["results"]!
        if shouldPerformSegue(withIdentifier: segueIDs.MapViewToDetailView, sender: self) {
            performSegue(withIdentifier: segueIDs.MapViewToDetailView, sender: self)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if detail == nil || currentWeatheronPin == nil {
            return false
        } else {
            return true
        }
    }
    
    
    @IBAction func longPressDropPin(_ recognizer: UIGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.began {
            dropPinOnLongTap(gestureRecognizer: recognizer)
            
        }
    }
    
    func dropPinOnLongTap(gestureRecognizer:UIGestureRecognizer){
        mapView.removeAnnotations(mapView.annotations)
//        mapView.removeAnnotation(selectedPin!)
        let touchPoint = gestureRecognizer.location(in: mapView)
        let newCoordinates = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        currentLocation = newCoordinates
        
        let annotation = MKPointAnnotation()
        annotation.title = "Dropped Pin"
        annotation.coordinate = newCoordinates
        mapView.addAnnotation(annotation)
        
        DAServiceClass.diveSearchByGeo(lat: annotation.coordinate.latitude, lng: annotation.coordinate.longitude, dist: radiusNauticalMiles)
        
        let location = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        addRadiusCircle(location: location, withRadiusInMetres: radiusMetres)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIDs.MapViewToDetailView {
            
            // MARK: Controller
            let detailView = segue.destination as! DetailTableViewController
            //let detailView = segue.destination as! WebViewController
            detailView.siteDetailObject = detail
            
            
            // MARK: Weather
            //detailView.detailWeatherObject = currentWeatheronPin
        }
    }
}




extension ViewController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        selectedPin = placemark                         // cache the pin
        mapView.removeAnnotations(mapView.annotations)  // clear existing pins
        currentLocation = placemark.coordinate
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city), \(state)"
        }
        
        mapView.addAnnotation(annotation)
//        let span = MKCoordinateSpanMake(0.9, 0.9)
//        let region = MKCoordinateRegionMake(placemark.coordinate, span)
//        mapView.setRegion(region, animated: true)
        
        let location = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        addRadiusCircle(location: location, withRadiusInMetres: radiusMetres)
        
        DAServiceClass.diveSearchByGeo(lat: (selectedPin?.coordinate.latitude)!, lng: (selectedPin?.coordinate.longitude)!, dist: radiusNauticalMiles)
        
        
    }
}


extension ViewController : MKMapViewDelegate {
    
    func addRadiusCircle(location: CLLocation, withRadiusInMetres metres: Double){
        self.mapView.delegate = self
        mapView.removeOverlays(mapView.overlays)
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, metres*2, metres*2)
        mapView.setRegion(region, animated: true)
        let circle = MKCircle(center: location.coordinate, radius:metres  as CLLocationDistance)
        self.mapView.add(circle)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay is MKCircle {
            let circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = UIColor(red:0.28, green:0.81, blue:0.68, alpha:1.0)
            circle.fillColor = UIColor(red:0.28, green:0.81, blue:0.68, alpha:0.1)
            circle.lineWidth = 1
            return circle
        } else {
            return MKOverlayRenderer()
        }
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let latitude = view.annotation?.coordinate.latitude
        let long = view.annotation?.coordinate.longitude
        let radius = 1.0
        weatherServiceClass.getWeatherByCoords(lat: latitude!, lng: long!, radius: radius)
        if let annotation = view.annotation as? DivesiteMapAnnotation {
            DAServiceClass.diveSearchByDetail(id: Int(annotation.site.id!)!)
        }
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        let pinToZoom = view.annotation
//        let span = MKCoordinateSpanMake(0.05, 0.05)
//        let region = MKCoordinateRegion(center: pinToZoom!.coordinate, span: span)
//        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
//        let pinToZoom = view.annotation
//        let span = MKCoordinateSpanMake(1.05, 1.05)
//        let region = MKCoordinateRegion(center: pinToZoom!.coordinate, span: span)
//        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            //draw the overlay
            
            DAServiceClass.diveSearchByGeo(lat: (annotation.coordinate.latitude), lng: (annotation.coordinate.longitude), dist: radiusNauticalMiles)
            currentLocation = annotation.coordinate
            let location = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
            addRadiusCircle(location: location, withRadiusInMetres: radiusMetres)
            return nil
        }
        
        let identifier = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        pinView?.pinTintColor = UIColor(red:0.29, green:0.54, blue:0.86, alpha:1.0)
        pinView?.canShowCallout = true
        pinView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
        pinView?.animatesDrop = true
        
        
        
        return pinView
    }
    
}

