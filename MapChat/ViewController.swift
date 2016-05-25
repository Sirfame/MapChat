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

class ViewController: UIViewController {
    
    let tableData = ["One","Two","Three"]
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    // IBOutlets //////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
    // MAP SCENE: sliderRadiusSlider - Slider beneath the map used to adjust the radius of
    // prospective chatters.
    @IBOutlet weak var sliderRadiusSlider: UISlider!
    
    // MAP SCENE: sliderRadiusSliderChanged - Action that occurs when sliderRadiusSlider is
    // slid.
    @IBAction func sliderRadiusSliderChanged(sender: UISlider) {
        
        let currentValue = Int(sender.value)
        lblRadius.text = "\(currentValue)"
        
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
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    // VIEWDIDLOAD ////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        NSLog("view loaded")
        
        let geofireRef = Firebase(url: "https://mapchat-2d278.firebaseio.com/")
        let geoFire = GeoFire(firebaseRef: geofireRef)
        
        geoFire.setLocation(CLLocation(latitude: 37.7853889, longitude: -122.4056973), forKey: "firebase-test")
        
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

