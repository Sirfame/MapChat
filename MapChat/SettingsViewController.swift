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

class SettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //
    let imagePicker = UIImagePickerController()
    var usersRef = Firebase(url: "https://mapchat-2d278.firebaseio.com/users/\(Device.DeviceId)")
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    // IBOutlets //////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
    // lblUserName - Label displaying the user's name.
    @IBOutlet weak var lblUserName: UILabel!
    
    // txtfldUserName - TextField to input the user's name.
    @IBOutlet weak var txtfldUserName: UITextField!
    
    // bttnChangePic - Button pressed when changing user's pic.
    @IBOutlet weak var bttnChangePic: UIButton!
    
    // bttnChangeName - Button pressed when changing user's name.
    @IBOutlet weak var bttnChangeName: UIButton!
    
    //
    @IBOutlet weak var imgviewUserPic: UIImageView!
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    // IBActions //////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
    // changeUserPic - Executed upon clicking bttnChangePic; changes the user's pic.
    @IBAction func changeUserPic(sender: UIButton) {
        NSLog("Changing user pic.")
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // changeUserName - Executed upon clicking bttnChangeName; changes the user's name.
    @IBAction func changeUserName(sender: UIButton) {
        NSLog("Changing user name.")
        let newName = txtfldUserName.text
        NSLog("New name: \(newName)")
        lblUserName.text = newName
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.textField.resignFirstResponder()
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
    }
    
    func storeUsername() {
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgviewUserPic.contentMode = .ScaleAspectFit
            imgviewUserPic.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}