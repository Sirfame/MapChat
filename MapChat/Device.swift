//
//  Device.swift
//  MapChat
//
//  Created by studentuser on 5/24/16.
//  Copyright © 2016 Neward's Favs. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import GeoFire
import Firebase

public class Device {
    
//    public static var Location : CLLocation {
//        get {return _location}
//        set(value) {_location = value}
//    }
//    
//    private static var _location : CLLocation = CLLocation(latitude : 0, longitude : 0)
    
    private static var _latitude : CLLocationDegrees = 0
    
    public static var Latitude : CLLocationDegrees {
        get {return _latitude}
        set(value) {_latitude = value}
    }
    
    private static var _longitude : CLLocationDegrees = 0
    
    public static var Longitude : CLLocationDegrees {
        get {return _longitude}
        set(value) {_longitude = value}
    }
    

    private static var _deviceId : String = ""
    
    public static var DeviceId : String {
        get { return _deviceId}
    }
    
    private static var _location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(CLLocationDegrees(0), CLLocationDegrees(0))
    
    public static var Location : CLLocationCoordinate2D {
        get {return _location}
        set(value) {_location = value}
    }
    
    public static var LocManager : CLLocationManager = CLLocationManager()
    
    public static func setDeviceId() {
        struct Platform {
            static let isSimulator: Bool = {
                var isSim = false
                #if arch(i386) || arch(x86_64)
                    isSim = true
                #endif
                return isSim
            }()
        }
        
        if Platform.isSimulator {
            _deviceId = "Simulator"
        }
        else {
            _deviceId = UIDevice.currentDevice().identifierForVendor!.UUIDString
        }
    }
    
    //let geofireRef = Firebase(url: "https://mapchat-2d278.firebaseio.com/location")
    //let geoFire = GeoFire(firebaseRef: geofireRef)
    
    public static var GeoFireRef : GeoFire {
        get {return _geofireRef}
        set(value) {_geofireRef = value}
    }
    
    private static var _geofireRef : GeoFire = GeoFire(firebaseRef: Firebase(url :  "https://mapchat-2d278.firebaseio.com/location"))
    
    private static var _currentChatBuddyID : String = ""
    public static var CurrentChatBuddyID : String {
        get {return _currentChatBuddyID}
        set(value) {_currentChatBuddyID = value}
    }
}
