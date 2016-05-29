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
    
    var usersInRange : [String] = []
    
  
    
    enum radiusChoice : CLLocationDistance {
        case fiveHundredFeet = 152.4
        case quarterMile = 402.3
        case halfMile = 804.7
        case oneMile = 1609.3
    }
    
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
    
    
    // MAP SCENE: sliderRadiusSliderChanged - Action that occurs when sliderRadiusSlider is
    // slid.
    @IBAction func sliderRadiusSliderChanged(sender: UISlider) {
        NSLog("slider radius changed \(sender.value)")
        
        switch Int(sender.value) {
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
        refreshRadiusCircle()
    }

    
    // MAP SCENE: lblRadius - Label beneath the slider indicating the currently selected
    // radius.
    @IBOutlet weak var lblRadius: UILabel!
    
    // MAP SCENE: bttnGo - Button beneath the slider. Randomly selects a person within the
    // radius and redirects the user to a new chat with them upon being pressed.
    @IBOutlet weak var bttnGo: UIButton!
    
    // MAP SCENE: bttnGoPressed - Action that occurs when bttnGo is pressed.
    @IBAction func bttnGoPressed(sender: UIButton) {
        let alertController = UIAlertController(title: "Are you ready to chat?", message:"", preferredStyle: UIAlertControllerStyle.Alert)
        
        if usersInRange.count > 0 {
            alertController.message = "You're in luck! Hit OK to be connected with a new chat buddy."
            alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
            
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: { action in self.performSegueWithIdentifier("chatsegue", sender: self) }))
        } else {
            alertController.message = "Sorry, there's no one currently in your vicinity! Try adjusting the range or come back later."
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        }
        
        self.presentViewController(alertController, animated: true, completion: nil)
        updateMap()
    }
   
    func startSendingLocation(){
        Device.setDeviceId()
        Device.GeoFireRef = GeoFire(firebaseRef: geofireRef)
        
        if !CLLocationManager.locationServicesEnabled() || !(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse) {
            locManager.requestWhenInUseAuthorization()
            // show error message here if the user doesn't allow access to location services
        } else {
            locManager.delegate = self
            locManager.distanceFilter = 10
            locManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locManager.startUpdatingLocation()
        }
    }
    
    // location manager delegate functions
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currLocation = locations[locations.count - 1]
        
        
        Device.Latitude = currLocation.coordinate.latitude
        Device.Longitude = currLocation.coordinate.longitude
        Device.Location = CLLocationCoordinate2DMake(Device.Latitude, Device.Longitude)
        
//        NSLog("device longitude \(Device.Longitude)")
//        NSLog("device latitude \(Device.Latitude)")

        Device.GeoFireRef.setLocation(CLLocation(latitude: Device.Latitude, longitude: Device.Longitude), forKey: Device.DeviceId)

        updateMap()
        findNearbyUsers()
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
    
    func updateMap() {
        zoomToLocation()
        refreshRadiusCircle()
    }
    
    func zoomToLocation() {
//        
//        func MKCoordinateRegionMakeWithDistance(_ centerCoordinate: CLLocationCoordinate2D, _ latitudinalMeters: CLLocationDistance, _ longitudinalMeters: CLLocationDistance) -> MKCoordinateRegion
        var longMeters : CLLocationDistance
        var latMeters : CLLocationDistance
        
        switch selectedRadius {
            case radiusChoice.fiveHundredFeet.rawValue :
                longMeters = radiusChoice.oneMile.rawValue
                latMeters = radiusChoice.oneMile.rawValue
            default:
                longMeters = radiusChoice.oneMile.rawValue
                latMeters = radiusChoice.oneMile.rawValue
        }
        
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(Device.Latitude, Device.Longitude)
        
        let region : MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(location, latMeters, longMeters)
        
        mapView.setRegion(region, animated: false)
    }
    
    func findNearbyUsers() {
        let center = CLLocation(latitude: Device.Latitude, longitude: Device.Longitude)
        // radius here is in kilometers, while selectedRadius is in meters
        
        let radiusKilometers = selectedRadius / 100.0
        let myQuery = Device.GeoFireRef.queryAtLocation(center, withRadius: radiusKilometers)
        
        myQuery.observeEventType(.KeyEntered, withBlock: { (key: String!, location: CLLocation!) in
            if key != Device.DeviceId {
                self.usersInRange.append(key)
//                NSLog("Key '\(key)' entered the search area and is at location '\(location)'")
            }
        })
    }
    
    func refreshRadiusCircle() {
        let overlays = mapView.overlays
        mapView.removeOverlays(overlays)
        radiusCircle = MKCircle(centerCoordinate: Device.Location, radius: CLLocationDistance(selectedRadius))
        mapView.addOverlay(radiusCircle)
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        NSLog("trying to render location")
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
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    // VIEWDIDLOAD ////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        NSLog("view loaded")
        mapView.tintColor = UIColor.blueColor()
        startSendingLocation()
        
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
}

