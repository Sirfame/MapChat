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
    
    // imagePicker - The ImagePickerController; picks images.
    let imagePicker = UIImagePickerController()
    //
    var usersRef = Firebase(url: "https://mapchat-2d278.firebaseio.com/users/\(Device.DeviceId)")
    
    
    // Ran into a bug here, deleted contents.
    func storeUsername() {
    }
    
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
    
    // imgviewUserPic - The user's pic.
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
        //
    }
    
    // changeUserName - Executed upon clicking bttnChangeName; changes the user's name.
    @IBAction func changeUserName(sender: UIButton) {
        NSLog("Changing user name.")
        let newName = txtfldUserName.text
        NSLog("New name: \(newName)")
        lblUserName.text = newName
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    // didReceiveMemoryWarning ////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.textField.resignFirstResponder()
    }
    */
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    // viewDidLoad ////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    // imagePicker ////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
    // imagePickerController - Handles the presentation of the imagePickerController.
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgviewUserPic.contentMode = .ScaleAspectFit
            imgviewUserPic.image = pickedImage
            // CODE TO RECEIVE pickedImage AND SEND TO FIREBASE HERE
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}