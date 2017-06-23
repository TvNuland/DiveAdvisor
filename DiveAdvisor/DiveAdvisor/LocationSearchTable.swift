//
//  LocationSearchTable.swift
//  DiveAdvisor
//
//  Created by Paul Geurts on 15/06/2017.
//  Copyright © 2017 ben smith. All rights reserved.
//

import UIKit
import MapKit

struct CellDetail {
    var name: String?
    var id: String?
    var country: String?
    var ocean: String?
    var placemark: MKPlacemark?
}

class LocationSearchTable: UITableViewController {
    
    

    var cellDetails: [CellDetail] = [] {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    var handleMapSearchDelegate:HandleMapSearch? = nil
    var searchText: String?
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(LocationSearchTable.diveSearchByNameObservers),
                                               name:  NSNotification.Name(rawValue: notificationIDs.diveSearchByName),
                                               object: nil)
    }
    
    func diveSearchByNameObservers(notification: NSNotification) {
        var diveDict = notification.userInfo as! Dictionary<String, [Sites]>
        let sites = diveDict["data"]!
        if sites.count == 0 {
            doAppleSearch()
        } else {
            cellDetails = []
            for site in sites {
                cellDetails.append(CellDetail(name: site.name, id: site.id, country: site.country, ocean: site.ocean, placemark: site.mapItem?.placemark))
            }
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
            self.cellDetails = []
            for mapItem in response.mapItems {
                self.cellDetails.append(CellDetail(name: mapItem.name, id: "", country: "", ocean: "", placemark: mapItem.placemark))
            }
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

    public func updateSearchResults(for searchController: UISearchController) {
        if searchController.isActive &&
            isMoreThanTwoCharacters(searchController) && hasSearchTextChanged(searchController) {
            cellDetails = [] 
            self.searchText = searchController.searchBar.text!
            self.scheduledSearch(searchBar: searchController.searchBar, page: 1)
        }
    }
    
    func isMoreThanTwoCharacters(_ searchController: UISearchController) -> Bool {
        return (searchController.searchBar.text?.characters.count)! > 2
    }
    
    func hasSearchTextChanged(_ searchController: UISearchController) -> Bool {
        return searchText != searchController.searchBar.text
    }
    
    func scheduledSearch(searchBar: UISearchBar, page: Int) {
        let searchDelaySeconds: Int = 1
        let popTime = DispatchTime.now() + .seconds(searchDelaySeconds)
        let text = searchBar.text!
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            if text == searchBar.text {
                DAServiceClass.diveSearchBy(name: text)
            }
        }
    }
    
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let searchBarText = searchController.searchBar.text else { return }
//        self.searchText = searchBarText
//        DAServiceClass.diveSearchBy(name: searchBarText)
//    }

}

extension LocationSearchTable {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDetails.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIDs.searchResultCell)!
        let item = cellDetails[indexPath.row]
        var cellText = item.name!
        if let country = item.country,
            country != "" {
            cellText.append(", \(country)")
        }
        if let ocean = item.ocean,
            ocean != "" {
            cellText.append(", \(ocean)")
        }
        cell.textLabel?.text = cellText
        cell.detailTextLabel?.text = ""
        //cell.detailTextLabel?.text = parseAddress(selectedItem: selectedItem)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = cellDetails[indexPath.row].placemark
        handleMapSearchDelegate?.dropPinZoomIn(placemark: selectedItem!, cellDetail: cellDetails[indexPath.row])
        //    selectedItem.coordinate
        dismiss(animated: true, completion: nil)
    }
}
