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
        
        if(selectedItem.administrativeArea == nil || selectedItem.locality == nil){
            return ""
        }
        
        
        return addressLine
    }
}

extension LocationSearchTable : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.view.backgroundColor = getBackgroundColor(icon: MainWeather.icon)
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
            for i in stride(from: self.matchingItems.count - 1, to: -1, by: -1) {
                let item = self.matchingItems[i].placemark
                if self.parseAddress(selectedItem: item) == "" {
                    print("remove: " + item.title!)
                    self.matchingItems.remove(at: i)
                }
            }
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
        cell.backgroundColor = getBackgroundColor(icon: MainWeather.icon)
        cell.textLabel?.textColor = getMainTextColor(icon: MainWeather.icon)
        cell.detailTextLabel?.textColor = getMainTextColor(icon: MainWeather.icon)
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
        if(self.parseAddress(selectedItem: selectedItem) != ""){
            dismiss(animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "문제가 발생했습니다.", message: "주소형식이 올바르지 않습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
