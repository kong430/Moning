//
//  MapViewController.swift
//  Moning
//
//  Created by Park MinGyeong on 2020/06/09.
//  Copyright © 2020 이제인. All rights reserved.
//

import UIKit
import MapKit

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class MapViewController: UIViewController, CLLocationManagerDelegate, UIViewControllerTransitioningDelegate{
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addButton: UIButton!
    let newPin = MKPointAnnotation()
    var resultSearchController:UISearchController? = nil
    var locationManager = CLLocationManager()
    var selectedPin:MKPlacemark? = nil
    var place = ""
    var location = ""
        
    override func viewDidLoad(){
        super.viewDidLoad()
        //Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //사용자 인증 요청 - 이거 나중에 수정
        locationManager.requestWhenInUseAuthorization()
        //위치 업데이트 시작
        locationManager.startUpdatingLocation()
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.showsCancelButton = true
        searchBar.becomeFirstResponder()
        searchBar.placeholder = "지역을 검색하세요"
        navigationItem.titleView = resultSearchController?.searchBar
    
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.obscuresBackgroundDuringPresentation = true
        definesPresentationContext = true
        locationSearchTable.mapView = mapView
        mapView.showsUserLocation = true
        locationSearchTable.handleMapSearchDelegate = self
        locationSearchTable.transitioningDelegate = self
        
        //self.place.delegate = self
    }
    
    @IBAction func buttonClick(_ sender: Any) {
        //UserDefaults.standard.set(placeList, forKey: "placeList")
        let item: PlaceList = PlaceList(place: place, location: location)
        placeList.append(item)
        _ = navigationController?.popViewController(animated: true)
        place = ""
        location = ""
        
    }
    
    func getDirections(){
        if let selectedPin = selectedPin {
            let mapItem = MKMapItem(placemark: selectedPin)
            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
            mapItem.openInMaps(launchOptions: launchOptions)
        }
    }
    
    func mapLongPress(_ recognizer: UIGestureRecognizer) {
           print("A long press has been detected.")
           let touchedAt = recognizer.location(in: self.mapView) // adds the location on the view it was pressed
           let touchedAtCoordinate : CLLocationCoordinate2D = mapView.convert(touchedAt, toCoordinateFrom: self.mapView) // will get coordinates

           let newPin = MKPointAnnotation()
           newPin.coordinate = touchedAtCoordinate
           mapView.addAnnotation(newPin)
    }
}

extension MapViewController{
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            /*let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)*/
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error:: \(error)")
    }
}

extension MapViewController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea{
            annotation.subtitle = state + " " + city + " " + searchItem
            location = annotation.subtitle!
            place = searchItem
        }
        
        if let city = placemark.locality,
            let state = placemark.administrativeArea,
            let street = placemark.thoroughfare{
            annotation.subtitle = state + " " + city + " " + street
            location = annotation.subtitle!
            place = searchItem
        }

        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}
