//
//  MainViewController.swift
//  Moning
//
//  Created by 이제인 on 2020/05/16.
//  Copyright © 2020 이제인. All rights reserved.
//

import UIKit
import CoreLocation


class MainViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    @IBAction func refreshButtonAction(_ sender: Any) {
        getCurrentLocation()
//        nameLabel.text = Place.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCurrentLocation()
        
        
//        nameLabel.text = Place.name
        weatherImage.image = UIImage(named: "01d.png")
        
    }
    
    
    var locationManager: CLLocationManager!
    
    func getCurrentLocation(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        var coor = locationManager.location?.coordinate
        if(coor==nil){
            print("error: location coordinate nil")
            return
        }
        
        Place.lat = coor?.latitude
        Place.lon = coor?.longitude
                
//        print(Place.lat)
//        print(Place.lon)

        let findLocation: CLLocation = CLLocation(latitude: coor!.latitude, longitude: coor!.longitude)
                let geoCoder: CLGeocoder = CLGeocoder()
                let local: Locale = Locale(identifier: "Ko-kr") // Korea
                geoCoder.reverseGeocodeLocation(findLocation, preferredLocale: local) { (place, error) in
                    if let address: [CLPlacemark] = place {
                        Place.name = String((address.last?.administrativeArea)!)+" "+String((address.last?.locality)!)+" "+String((address.last?.thoroughfare)!)
                        print(Place.name)
                    }
                }
        
        nameLabel.text = Place.name
    }
    
}
