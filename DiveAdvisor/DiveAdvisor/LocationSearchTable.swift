//
//  LocationSearchTable.swift
//  DiveAdvisor
//
//  Created by Paul Geurts on 15/06/2017.
//  Copyright © 2017 ben smith. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchTable: UITableViewController {
    var matchingItems: [MKMapItem] = []{
        didSet{
            self.tableView.reloadData()
        }
    }
    var mapView: MKMapView?
    var handleMapSearchDelegate:HandleMapSearch? = nil
    var searchText: String?
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(LocationSearchTable.diveSearchByNameObservers),
                                               name:  NSNotification.Name(rawValue: notificationIDs.diveSearchByName),
                                               object: nil)
    }
    
    func diveSearchByNameObservers(notification: NSNotification) {
        var diveDict = notification.userInfo as! Dictionary<String, [Matches]>
        let matches = diveDict["data"]!
        if matches.count == 0 {
            doAppleSearch()
        } else {
            var temp: [MKMapItem] = []
            for match in matches {
                temp.append(match.mapItem!)
            }
            matchingItems = temp
        }
    }
    
    
    func doAppleSearch() {
        //do this if search restulst are empty
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchText!
        //        request.region = (mapView?.region)!
        let search = MKLocalSearch(request: request)
        
        search.start(completionHandler: { response, _ in
            guard let response = response else {
                return
            }
            //response.mapItems
            //MKPlacemark
            self.matchingItems = response.mapItems
        })
    }
 
    /* Adding address line for apple maps search --- not needed?
    func parseAddress(selectedItem:MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        //let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            //secondSpace,
            // state
            //selectedItem.administrativeArea ?? "",
            //comma + space
            ", ",
            // country
            selectedItem.country ?? ""
            
        )
        return addressLine
    }
 */
    
}

extension LocationSearchTable: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView,
            let searchBarText = searchController.searchBar.text else { return }
        self.searchText = searchBarText
        DAServiceClass.diveSearchBy(name: searchBarText)
    }
}

extension LocationSearchTable {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIDs.searchResultCell)!
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = ""
        //cell.detailTextLabel?.text = parseAddress(selectedItem: selectedItem)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        handleMapSearchDelegate?.dropPinZoomIn(placemark: selectedItem)
        //    selectedItem.coordinate
        dismiss(animated: true, completion: nil)
    }
}





