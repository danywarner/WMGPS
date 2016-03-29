//
//  ViewController.swift
//  WMGPS
//
//  Created by Daniel Warner on 3/29/16.
//  Copyright © 2016 Daniel Warner. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var latitudLbl: UILabel!
    @IBOutlet weak var longitudLbl: UILabel!
    @IBOutlet weak var altitudLbl: UILabel!
    @IBOutlet weak var precisionHLbl: UILabel!
    @IBOutlet weak var precisionVLbl: UILabel!
    @IBOutlet weak var distanciaLbl: UILabel!
    
    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 10.0
        startLocation = nil
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let latestLocation: AnyObject = locations[locations.count - 1]
        
        latitudLbl.text = String(format: "%.4f",
                               latestLocation.coordinate.latitude)
        longitudLbl.text = String(format: "%.4f",
                                latestLocation.coordinate.longitude)
        precisionHLbl.text = String(format: "%.4f",
                                         latestLocation.horizontalAccuracy)
        altitudLbl.text = String(format: "%.4f",
                               latestLocation.altitude)
        precisionVLbl.text = String(format: "%.4f",
                                       latestLocation.verticalAccuracy)
        
        
        if startLocation == nil {
            startLocation = latestLocation as! CLLocation
        }
        
        let distanceBetween: CLLocationDistance =
            latestLocation.distanceFromLocation(startLocation)
        
        distanciaLbl.text = String(format: "%.2f", distanceBetween)
    }
    
    func locationManager(manager: CLLocationManager,
                         didFailWithError error: NSError) {
        
    }
    
    

    @IBAction func resetDistance(sender: AnyObject) {
        startLocation = nil
    }

}

