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
    }
    
    // changeUserName - Executed upon clicking bttnChangeName; changes the user's name.
    @IBAction func changeUserName(sender: UIButton) {
        NSLog("Changing user name.")
        let newName = txtfldUserName.text
        NSLog("New name: \(newName)")
        lblUserName.text = newName
        print(Device.DeviceId)
//        usersRef.observeEventType(.Value, withBlock: { snapshot in
//            print(snapshot.value)
//            }, withCancelBlock: { error in
//                print(error.description)
//        }) REMOVE THIS LATERRRRRR
        let usernameRef = usersRef.childByAppendingPath("\(Device.DeviceId)").childByAppendingPath("username")
        usernameRef.setValue(newName)
	
        // CODE TO SEND newName TO FIREBASE HERE
        // May want to verify if names are already taken. I think it's something Neward would
        // try to trip us up.
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    // didReceiveMemoryWarning ////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    // viewDidLoad ////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    // imagePicker ////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
    // imagePickerController - Handles the presentation of the imagePickerController; sets
    // imgViewUserPic to the image selected in the imagePickerController.
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgviewUserPic.contentMode = .ScaleAspectFit
            imgviewUserPic.image = pickedImage
            // CODE TO SEND pickedImage TO FIREBASE HERE
            let img = ["image": "testImage"]
            let imageRef = usersRef.childByAppendingPath("\(Device.DeviceId)").childByAppendingPath("image")
            imageRef.setValue(img)
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // imagePickerControllerDidCancel - Specifies what to do if an image is not selected when
    // using imagePickerController.
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}