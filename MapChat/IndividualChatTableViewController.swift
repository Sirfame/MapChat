//
//  ChatMenuTableViewController.swift
//  MapChat
//
//  Created by Ted Neward on 5/24/16.
//  Copyright © 2016 Neward's Favs. All rights reserved.
//

import UIKit

class ChatMenuTableViewController: UITableViewController {
    
    // ongoingConversations: An array of Strings indicating the latest message of each conversation.
    var ongoingConversations = [String]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // loadDummyData - Load fake conversation data.
        func loadDummyData() {
            ongoingConversations.append("Joel: waddup")
            ongoingConversations.append("Chris: pls answer")
            ongoingConversations.append("Alyssa: im doing geofire")
            ongoingConversations.append("Sirfam: live from the ER")
        }
        
        loadDummyData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    // Returns the number of sections in the TableView.
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        NSLog("Sections in ChatMenu TableView: \(ongoingConversations.count)")
        return ongoingConversations.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
