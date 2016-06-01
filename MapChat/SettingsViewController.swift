//
//  SettingsViewController.swift
//  MapChat
//
//  Created by iGuest on 5/31/16.
//  Copyright © 2016 Neward's Favs. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SettingsViewController : UIViewController {
    
    var username = "ALYSSAAA TEST"
    
    var usersRef = Firebase(url: "https://mapchat-2d278.firebaseio.com/users/\(Device.DeviceId)")
    
    @IBOutlet weak var UserNameLabel: UILabel!
    
    @IBAction func ChangeProfilePic(sender: AnyObject) {
        
    }
    
    @IBAction func ChangeUserName(sender: AnyObject) {

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBOutlet weak var textField: UITextField!
    
    /*func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.textField.resignFirstResponder()
    }
    */
    override func viewDidLoad() {

    }
    
    func storeUsername() {
        let username = ["username": self.username]
        
        usersRef.updateChildValues(username)
    }
}