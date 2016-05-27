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

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let tableData = ["One","Two","Three"]
    
    let locManager = Device.LocManager
    
    let geofireRef = Firebase(url: "https://mapchat-2d278.firebaseio.com/location")
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    // IBOutlets //////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    @IBOutlet weak var mapView: MKMapView!
    
    // MAP SCENE: sliderRadiusSlider - Slider beneath the map used to adjust the radius of
    // prospective chatters.
    @IBOutlet weak var sliderRadiusSlider: UISlider!
    
    
    // MAP SCENE: sliderRadiusSliderChanged - Action that occurs when sliderRadiusSlider is
    // slid.
    @IBAction func sliderRadiusSliderChanged(sender: UISlider) {
        
        let currentValue = Int(sender.value)
        lblRadius.text = "I want to talk to people within \(currentValue) miles."
        
    }
    
    // MAP SCENE: lblRadius - Label beneath the slider indicating the currently selected
    // radius.
    @IBOutlet weak var lblRadius: UILabel!
    
    // MAP SCENE: bttnGo - Button beneath the slider. Randomly selects a person within the
    // radius and redirects the user to a new chat with them upon being pressed.
    @IBOutlet weak var bttnGo: UIButton!
    
    // MAP SCENE: bttnGoPressed - Action that occurs when bttnGo is pressed.
    @IBAction func bttnGoPressed(sender: UIButton) {
        
        let alertController = UIAlertController(title: "WHAT HAVE YOU DONE??", message: "YOU'VE DOOMED US ALL!!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
   
    
    func startSendingLocation(){
        Device.setDeviceId()
        
        if !CLLocationManager.locationServicesEnabled() || !(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse) {
            locManager.requestWhenInUseAuthorization()
        } else {
            locManager.delegate = self
            locManager.distanceFilter = 10
            locManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locManager.startUpdatingLocation()
        }
    }
    
    // location manager delegate functions
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        NSLog("received location")
        let currLoc = locations[locations.count - 1]
        let geoFire = GeoFire(firebaseRef: geofireRef)
        geoFire.setLocation(CLLocation(latitude: currLoc.coordinate.latitude, longitude: currLoc.coordinate.longitude), forKey: Device.DeviceId)

        zoomToLocation(currLoc.coordinate.latitude, long: currLoc.coordinate.longitude)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        NSLog("failed to receive location")
        NSLog("\(error)")
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)  {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            startSendingLocation()
        }
    }
    
    func zoomToLocation(lat : CLLocationDegrees, long : CLLocationDegrees) {
        let latDelta : CLLocationDegrees = 0.01
        
        let longDelta : CLLocationDegrees = 0.01
        
        let span : MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
        
        let region : MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        mapView.setRegion(region, animated: false)
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    // VIEWDIDLOAD ////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        NSLog("view loaded")
        startSendingLocation()
        
        // Initializing radius slider properties. Defaults to Int 2 miles.
        sliderRadiusSlider.minimumValue = 1
        sliderRadiusSlider.maximumValue = 10
        sliderRadiusSlider.value = 2
    }
    

    ///////////////////////////////////////////////////////////////////////////////////////////////
    // DIDRECEIVEMEMORYWARNING ////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

