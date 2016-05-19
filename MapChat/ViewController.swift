//
//  ViewController.swift
//  MapChat
//
//  Created by Yoloswaggins on 5/18/16.
//  Copyright © 2016 Neward's Favs. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

