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

public class Device {
    
    private static var _deviceId : String = ""
    
    public static var DeviceId : String {
        get { return _deviceId}
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
    
}
