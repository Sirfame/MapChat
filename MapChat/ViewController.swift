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

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let tableData = ["One","Two","Three"]
    
    let locManager = Device.LocManager
    
    let geofireRef = Firebase(url: "https://mapchat-2d278.firebaseio.com/location")
    
    let usersRef = Firebase(url: "https://mapchat-2d278.firebaseio.com/users")
    
    var usersInRange : [String] = []
    
    var longMeters : CLLocationDistance = 0
    var latMeters : CLLocationDistance = 0
    
    var currRadius = 1
    
    enum radiusChoice : CLLocationDistance {
        case fiveHundredFeet = 152.4
        case quarterMile = 402.3
        case halfMile = 804.7
        case oneMile = 1609.3
    }
    
    var myQuery = Device.GeoFireRef.queryAtLocation(CLLocation(latitude: Device.Latitude, longitude: Device.Longitude), withRadius: radiusChoice.fiveHundredFeet.rawValue / 1000.0)
    
    // radius is in meters
    // increments that the user can choose are 500ft, .25 miles, .5 miles, and 1 mile
    var selectedRadius : CLLocationDistance = radiusChoice.fiveHundredFeet.rawValue
    
    var radiusCircle = MKCircle(centerCoordinate: CLLocationCoordinate2DMake(0, 0), radius: CLLocationDistance(0))
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    // IBOutlets //////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    @IBOutlet weak var mapView: MKMapView!
    
    // MAP SCENE: sliderRadiusSlider - Slider beneath the map used to adjust the radius of
    // prospective chatters.
    @IBOutlet weak var sliderRadiusSlider: UISlider!
    

    
    // MAP SCENE: lblRadius - Label beneath the slider indicating the currently selected
    // radius.
    @IBOutlet weak var lblRadius: UILabel!
    
    // MAP SCENE: bttnGo - Button beneath the slider. Randomly selects a person within the
    // radius and redirects the user to a new chat with them upon being pressed.
    @IBOutlet weak var bttnGo: UIButton!
    
    // MAP SCENE: sliderRadiusSliderChanged - Action that occurs when sliderRadiusSlider is
    // slid.
    @IBAction func sliderRadiusSliderChanged(sender: UISlider) {
        let roundedValue = Int(round(sender.value))
        
        if roundedValue != currRadius {
            switch roundedValue {
            case 1 :
                lblRadius.text = "Closest (500 ft)"
                selectedRadius = radiusChoice.fiveHundredFeet.rawValue
                break
            case 2 :
                lblRadius.text = "Close (0.25 miles)"
                selectedRadius = radiusChoice.quarterMile.rawValue
                break
            case 3 : lblRadius.text = "Farther (0.5 miles)"
            selectedRadius = radiusChoice.halfMile.rawValue
                break
            case 4 : lblRadius.text = "Farthest (1 mile)"
            selectedRadius = radiusChoice.oneMile.rawValue
                break
            default : lblRadius.text = "Closest (500 ft)"
            selectedRadius = radiusChoice.fiveHundredFeet.rawValue
                break
            }
            currRadius = roundedValue
            
            let kilometersRadius = selectedRadius / 1000.0
            myQuery.radius = kilometersRadius
            
            updateMap()
        }
    }
    
    // MAP SCENE: bttnGoPressed - Action that occurs when bttnGo is pressed.
    @IBAction func bttnGoPressed(sender: UIButton) {
        NSLog("\(usersInRange.description)")
        NSLog("showing alert controller")
        let alertController = UIAlertController(title: "Are you ready to chat?", message:"", preferredStyle: UIAlertControllerStyle.Alert)
        
        if self.usersInRange.count > 0 {
            alertController.message = "You're in luck! Hit OK to be connected with a new chat buddy."
            alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
            
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: { action in
                self.setChatBuddy()
                self.performSegueWithIdentifier("GoToChat", sender: self) }))
        } else {
            alertController.message = "Sorry, there's no one currently in your vicinity! Try adjusting the chat radius or come back later."
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        }
        self.presentViewController(alertController, animated: true, completion: nil)
        self.updateMap()
    }
    
    func setChatBuddy() {
        var randomNumber = 0

        if self.usersInRange.count > 1 {
            randomNumber  = Int(arc4random_uniform(UInt32(self.usersInRange.count)))
        }

        if (self.usersInRange.count > 0) {
            Device.CurrentChatBuddyID = self.usersInRange[randomNumber]
        } else {
            Device.CurrentChatBuddyID = ""
        }
        NSLog("chat buddy set, device ID set to \(Device.CurrentChatBuddyID)")
    }
    
    // if the user has not enabled authorization, request authorization. Otherwise, start sending the user location.
    func startSendingLocation(){
        
        
        if !CLLocationManager.locationServicesEnabled() || !(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse) {
            locManager.requestWhenInUseAuthorization()
            // show error message here if the user doesn't allow access to location services
        } else {
            Device.setDeviceId()
            Device.GeoFireRef = GeoFire(firebaseRef: geofireRef)
            locManager.delegate = self
            locManager.distanceFilter = 10
            locManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locManager.startUpdatingLocation()
        }
    }
    
    // when the location manager receives a location update, update the device's location
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currLocation = locations[locations.count - 1]
        
        
        Device.Latitude = currLocation.coordinate.latitude
        Device.Longitude = currLocation.coordinate.longitude
        Device.Location = CLLocationCoordinate2DMake(Device.Latitude, Device.Longitude)
        
//        NSLog("device longitude \(Device.Longitude)")
//        NSLog("device latitude \(Device.Latitude)")

        Device.GeoFireRef.setLocation(CLLocation(latitude: Device.Latitude, longitude: Device.Longitude), forKey: Device.DeviceId)
        
        // drogueria de la pildora 19.4287163,-99.138813
        Device.GeoFireRef.setLocation(CLLocation(latitude: 19.4287163, longitude: -99.138813), forKey: "Test-Within half miles")
//        Device.GeoFireRef.setLocation(CLLocation(latitude: 19.4356596, longitude: -99.137922), forKey: "Test-Within half miles2")
//        
//        Device.GeoFireRef.setLocation(CLLocation(latitude: 19.4356596, longitude: -99.137922), forKey: "Test-Within 1 mile")
//        Device.GeoFireRef.setLocation(CLLocation(latitude: 19.4356596, longitude: -99.137922), forKey: "Test-Within 1 mile2")
        myQuery.center = CLLocation(latitude: Device.Latitude, longitude: Device.Longitude)
        updateMap()
    }
    
    // if the location manager fails to get a location update, log it
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        NSLog("failed to receive location")
        NSLog("\(error)")
    }
    
    // if the location status gets changed so that the user allows their location to be sent, start updating the location
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)  {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            startSendingLocation()
        }
    }
    
    // rezoom the map, see if there are any nearby users, and refresh the radius
    func updateMap() {
        zoomToLocation()
        refreshRadiusCircle()
    }
    
    func zoomToLocation() {
        switch selectedRadius {
//            case radiusChoice.fiveHundredFeet.rawValue, radiusChoice.quarterMile.rawValue :
//                NSLog("500 ft case")
//                if longMeters <= (selectedRadius * 2) || longMeters >= (selectedRadius * 3) {
//                    longMeters = radiusChoice.halfMile.rawValue
//                    latMeters = radiusChoice.halfMile.rawValue
//                }
            case radiusChoice.oneMile.rawValue :
                if longMeters <= (selectedRadius * 2) {
                    longMeters = radiusChoice.oneMile.rawValue * 2.25
                    latMeters = radiusChoice.oneMile.rawValue * 2.25
                }
            default:
                longMeters = radiusChoice.oneMile.rawValue
                latMeters = radiusChoice.oneMile.rawValue
        }
        
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(Device.Latitude, Device.Longitude)
        
        let region : MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(location, latMeters, longMeters)
        
        mapView.setRegion(region, animated: false)
    }
    
    
    func setUpGeoQuery(){
        NSLog("\(myQuery.radius)")
        myQuery.observeEventType(.KeyEntered, withBlock: { (key: String!, location: CLLocation!) in
            NSLog("adding to users array \(key)")
            NSLog("\(self.myQuery.radius)")
            if key != Device.DeviceId {
                self.usersInRange.append(key)
//                NSLog("Key '\(key)' entered the search area and is at location '\(location)'")
            }
        })
        
        myQuery.observeEventType(.KeyExited, withBlock: { (key: String!, location: CLLocation!) in
            NSLog("removing from users array \(key)")
            NSLog("\(self.myQuery.radius)")
            for i in 0 ..< self.usersInRange.count {
                let currKey = self.usersInRange[i]
                if currKey == key {
                    self.usersInRange.removeAtIndex(i)
                }
            }
            
        })
//        var randomNumber = 0
//        
//        if self.usersInRange.count > 1 {
//            randomNumber  = Int(arc4random_uniform(UInt32(self.usersInRange.count)))
//        }
//        
//        if (self.usersInRange.count > 0) {
//            Device.CurrentChatBuddyID = self.usersInRange[randomNumber]
//        } else {
//            Device.CurrentChatBuddyID = ""
//        }
        NSLog("Leaving find nearby user")
    }
    
    func refreshRadiusCircle() {
        let overlays = mapView.overlays
        mapView.removeOverlays(overlays)
        radiusCircle = MKCircle(centerCoordinate: Device.Location, radius: CLLocationDistance(selectedRadius))
        mapView.addOverlay(radiusCircle)
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = UIColor(red: 0, green: 122.0/255.0, blue: 255, alpha: 1)
            circle.fillColor = UIColor(red: 0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 0.5)
            circle.lineWidth = 1
            return circle
        } else {
            return MKOverlayRenderer()
        }
    }
    
//    func getUserInfo() {
//        usersRef.once(Device.DeviceId, function(data) {
//            // do some stuff once
//            });
//    }
    ///////////////////////////////////////////////////////////////////////////////////////////////
    // VIEWDIDLOAD ////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        NSLog("view loaded")
        mapView.tintColor = UIColor.blueColor()
        setUpGeoQuery()
        startSendingLocation()
//        getUserInfo()
        
        // Initializing radius slider properties. Defaults to
        sliderRadiusSlider.minimumValue = 1
        sliderRadiusSlider.maximumValue = 4
        sliderRadiusSlider.value = 1
    }
    

    ///////////////////////////////////////////////////////////////////////////////////////////////
    // DIDRECEIVEMEMORYWARNING ////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoToChat" {
            if let destinationVC = segue.destinationViewController as? MessageViewController {
                destinationVC.senderId = Device.DeviceId
                destinationVC.senderDisplayName = Device.Username
            }
        }
        
    }
}

