//
//  AllChatsViewController.swift
//  MapChat
//
//  Created by iGuest on 5/31/16.
//  Copyright © 2016 Neward's Favs. All rights reserved.
//

import Foundation
import UIKit
import Firebase

// AllChatsViewController - Controls the ChatMenu, containing all running chats.

class AllChatsViewController : UIViewController, UITableViewDataSource {
    
    var usersRef = Firebase(url: "https://mapchat-2d278.firebaseio.com/users")
    
    
    var displayIds: [String] = []
    
    var chats: [String] = []
    
    @IBOutlet weak var chatTableView: UITableView!
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    // VIEWDIDLOAD ////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        // Injects dummy data for testing purposes.
//        func injectDummyData() {
//            convoArray.append((username: "Chris", message: "wadup fam"))
//            convoArray.append((username: "Joel", message: "help swift is killing me"))
//            convoArray.append((username: "Sirfame", message: "yolo"))
//            convoArray.append((username: "Alyssa", message: "hi peeps"))
//        }
//        injectDummyData()
        getChatData()
        
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    // DIDRECEIVEMEMORYWARNING ////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    // TABLE CONFIGURATION ////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
    // There is one section in the table view.
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // The table has as many rows as there are convorsations in the convoArray.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    // Creates and configures cells to populate the convorsation table view.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "AllChatsTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! AllChatsTableViewCell
        
        cell.lblUser.text = displayIds[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        
        NSLog(self.displayIds[row])
        performSegueWithIdentifier("IndividualChatSegue", sender: self)
        
    }
    
    func getChatData() {
        var chatsRef = usersRef
        chatsRef = chatsRef.childByAppendingPath("\(Device.DeviceId)").childByAppendingPath("chats")
        NSLog("inside get chat data")
        chatsRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            NSLog("\(snapshot.key)")
            self.chats.append(snapshot.key)
            self.displayIds = self.chats
            self.chatTableView.reloadData()
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "IndividualChatSegue" {
            if let destinationVC = segue.destinationViewController as? MessageViewController {
                destinationVC.senderId = Device.DeviceId
                destinationVC.senderDisplayName = Device.Username
                //Device.CurrChatId =
            }
        }
    }
}
