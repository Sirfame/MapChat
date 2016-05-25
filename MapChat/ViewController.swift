//
//  ViewController.swift
//  MapChat
//
//  Created by Yoloswaggins on 5/18/16.
//  Copyright © 2016 Neward's Favs. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import GeoFire
import CoreLocation
import MapKit

class ViewController: UIViewController {
   
    ///////////////////////////////////////////////////////////////////////////////////////////////
    // IBOutlets //////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
    // MAP SCENE: sliderRadiusSlider - Slider beneath the map used to adjust the radius of
    // prospective chatters.
    @IBOutlet weak var sliderRadiusSlider: UISlider!

    // MAP SCENE: lblRadius - Label beneath the slider indicating the currently selected
    // radius.
    @IBOutlet weak var lblRadius: UILabel!

    // MAP SCENE: bttnGo - Button beneath the slider. Randomly selects a person within the
    // radius and redirects the user to a new chat with them upon being pressed.
    @IBOutlet weak var bttnGo: UIButton!
    
    func sendLocation() -> (String, String) {
        let geofireRef = Firebase(url: "https://mapchat-2d278.firebaseio.com/location")
        let geoFire = GeoFire(firebaseRef: geofireRef)
        
        Device.setDeviceId()
        
        let locManager = Device.LocManager
    
        if !CLLocationManager.locationServicesEnabled() || !(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse) {
            
            locManager.requestWhenInUseAuthorization()
        }

        NSLog(Device.DeviceId)
        
        geoFire.setLocation(CLLocation(latitude: 38.7853889, longitude: -122.4056973), forKey: Device.DeviceId)
        
        return("", "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("view loaded")
        sendLocation()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

