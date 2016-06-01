//
//  AllChatsViewController.swift
//  MapChat
//
//  Created by iGuest on 5/31/16.
//  Copyright © 2016 Neward's Favs. All rights reserved.
//

import Foundation
import UIKit

// AllChatsViewController - Controls the ChatMenu, containing all running chats.

class AllChatsViewController : UIViewController, UITableViewDataSource {
    
    // convoArray - An array of tuples containing the username and the latest message of the
    // conversation with said user.
    var convoArray: [(username: String, message: String)] = [("USERNAME", "MESSAGE")]
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    // VIEWDIDLOAD ////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        // Injects dummy data for testing purposes.
        func injectDummyData() {
            convoArray.append((username: "Chris", message: "wadup fam"))
            convoArray.append((username: "Joel", message: "help swift is killing me"))
            convoArray.append((username: "Sirfame", message: "yolo"))
            convoArray.append((username: "Alyssa", message: "hi peeps"))
        }
        injectDummyData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // There is one section in the table view.
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }
    
    // The table has as many rows as there are convorsations in the convoArray.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return convoArray.count
    }
    
    // Creates and configures cells to populate the convorsation table view.
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "AllChatsTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! AllChatsTableViewCell
        return cell
    }

    
}
