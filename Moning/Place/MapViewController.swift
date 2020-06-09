//
//  MapViewController.swift
//  Moning
//
//  Created by Park MinGyeong on 2020/06/09.
//  Copyright © 2020 이제인. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate{
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    override func viewDidLoad(){
        //Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //사용자 인증 요청 - 이거 나중에 수정
        locationManager.requestWhenInUseAuthorization()
        //위치 업데이트 시작
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
    }
    
    func myLocation(latitude: CLLocationDegrees, longtitude: CLLocationDegrees, delta: Double){
        let coordinateLocation = CLLocationCoordinate2DMake(latitude, longtitude)
        //let spanValue = MKCoordinateSpanMake(delta, delta)
        let spanValue = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        let locationRegion = MKCoordinateRegion(center: coordinateLocation, span: spanValue)
        mapView.setRegion(locationRegion, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let lastLocation = locations.last
        myLocation(latitude: (lastLocation?.coordinate.latitude)!, longtitude: (lastLocation?.coordinate.longitude)!, delta: 0.01)
        
    }
    
}
