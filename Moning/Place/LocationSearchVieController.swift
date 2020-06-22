//
//  LocationSearchVieController.swift
//  Moning
//
//  Created by Park MinGyeong on 2020/06/21.
//  Copyright © 2020 이제인. All rights reserved.
//

import UIKit
import MapKit
var searchItem = ""
var cellName = ""
var cellDetail = ""
class LocationSearchTable : UITableViewController {
    var matchingItems:[MKMapItem] = []
    var mapView: MKMapView? = nil
    var handleMapSearchDelegate:HandleMapSearch? = nil
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    func parseAddress(selectedItem:MKPlacemark) -> String {
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : " "
        // put a comma between street and city/state
        /*let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""*/
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : " "
        
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // state
            selectedItem.administrativeArea ?? "",
            firstSpace,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            secondSpace,
            // street number
            selectedItem.subThoroughfare ?? ""
        )
        return addressLine
    }
}

extension LocationSearchTable : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView,
            let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
}

extension LocationSearchTable {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let selectedItem = matchingItems[indexPath.row].placemark
        searchItem = selectedItem.name!
        cell.textLabel?.text = selectedItem.name
        cellName = selectedItem.name!
        cell.detailTextLabel?.text = parseAddress(selectedItem: selectedItem)
        cellDetail = parseAddress(selectedItem: selectedItem)
        return cell
    }

}

extension LocationSearchTable {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        handleMapSearchDelegate?.dropPinZoomIn(placemark: selectedItem)
        dismiss(animated: true, completion: nil)
    }
}
